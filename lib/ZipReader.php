<?php
final class ZipReader {
    private const MAX_ARCHIVE_BYTES = 12582912;      // 12 MB
    private const MAX_ENTRIES = 300;
    private const MAX_ENTRY_COMPRESSED = 6291456;    // 6 MB
    private const MAX_ENTRY_UNCOMPRESSED = 12582912; // 12 MB
    private const MAX_RATIO = 120;

    public static function entry(string $path,string $wanted): ?string {
        if(!is_file($path))return null;
        $size=@filesize($path);if($size===false||$size<=0||$size>self::MAX_ARCHIVE_BYTES)throw new RuntimeException('Archive vượt giới hạn an toàn.');
        $data=@file_get_contents($path);if($data===false)return null;return self::entryFromData($data,$wanted);
    }
    public static function entryFromData(string $zip,string $wanted): ?string {
        if(strlen($zip)>self::MAX_ARCHIVE_BYTES)throw new RuntimeException('Archive vượt giới hạn an toàn.');
        if($wanted===''||str_contains($wanted,'..')||str_contains($wanted,'\\')||str_starts_with($wanted,'/'))throw new RuntimeException('Đường dẫn entry không an toàn.');
        $eocd=strrpos($zip,"PK\x05\x06");if($eocd===false||strlen($zip)<$eocd+22)return null;
        $entryCount=unpack('v',substr($zip,$eocd+10,2))[1];if($entryCount>self::MAX_ENTRIES)throw new RuntimeException('Archive có quá nhiều entry.');
        $cdSize=unpack('V',substr($zip,$eocd+12,4))[1];$cdOffset=unpack('V',substr($zip,$eocd+16,4))[1];
        if($cdSize>self::MAX_ARCHIVE_BYTES||$cdOffset+$cdSize>strlen($zip))return null;
        $pos=$cdOffset;$end=$cdOffset+$cdSize;$scanned=0;
        while($pos+46<=$end&&substr($zip,$pos,4)==="PK\x01\x02"){
            if(++$scanned>self::MAX_ENTRIES)throw new RuntimeException('Archive có quá nhiều entry.');
            $method=unpack('v',substr($zip,$pos+10,2))[1];$compSize=unpack('V',substr($zip,$pos+20,4))[1];$uncompSize=unpack('V',substr($zip,$pos+24,4))[1];
            $nameLen=unpack('v',substr($zip,$pos+28,2))[1];$extraLen=unpack('v',substr($zip,$pos+30,2))[1];$commentLen=unpack('v',substr($zip,$pos+32,2))[1];$localOffset=unpack('V',substr($zip,$pos+42,4))[1];$name=substr($zip,$pos+46,$nameLen);
            if($name===$wanted){
                if($compSize>self::MAX_ENTRY_COMPRESSED||$uncompSize>self::MAX_ENTRY_UNCOMPRESSED)throw new RuntimeException('Entry trong archive vượt giới hạn an toàn.');
                if($compSize>0&&$uncompSize>0&&($uncompSize/$compSize)>self::MAX_RATIO)throw new RuntimeException('Archive có tỷ lệ nén bất thường.');
                if($localOffset+30>strlen($zip)||substr($zip,$localOffset,4)!=="PK\x03\x04")return null;$ln=unpack('v',substr($zip,$localOffset+26,2))[1];$le=unpack('v',substr($zip,$localOffset+28,2))[1];$off=$localOffset+30+$ln+$le;if($off+$compSize>strlen($zip))return null;
                $compressed=substr($zip,$off,$compSize);if($method===0){if(strlen($compressed)>self::MAX_ENTRY_UNCOMPRESSED)throw new RuntimeException('Entry quá lớn.');return $compressed;}
                if($method===8){$out=@gzinflate($compressed,self::MAX_ENTRY_UNCOMPRESSED);if($out===false)return null;if(strlen($out)>self::MAX_ENTRY_UNCOMPRESSED)throw new RuntimeException('Entry giải nén quá lớn.');return $out;}return null;
            }
            $pos+=46+$nameLen+$extraLen+$commentLen;
        }return null;
    }
}
