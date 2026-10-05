<?php
final class XlsxReader {
    private const MAX_XML_BYTES=10485760;
    private const MAX_ROWS=5000;
    private const MAX_COLUMNS=100;
    public static function rows(string $path): array {
        $shared=[];$ss=ZipReader::entry($path,'xl/sharedStrings.xml');if($ss!==null){if(strlen($ss)>self::MAX_XML_BYTES)throw new RuntimeException('XLSX sharedStrings quá lớn.');preg_match_all('/<si[^>]*>(.*?)<\/si>/su',$ss,$m);foreach($m[1] as $si){preg_match_all('/<t[^>]*>(.*?)<\/t>/su',$si,$tm);$shared[]=html_entity_decode(strip_tags(implode('',$tm[1])),ENT_QUOTES|ENT_XML1,'UTF-8');}}
        $sheet=ZipReader::entry($path,'xl/worksheets/sheet1.xml');if($sheet===null)throw new RuntimeException('XLSX không đọc được sheet đầu tiên.');if(strlen($sheet)>self::MAX_XML_BYTES)throw new RuntimeException('XLSX worksheet quá lớn.');preg_match_all('/<row[^>]*>(.*?)<\/row>/su',$sheet,$rows);if(count($rows[1])>self::MAX_ROWS)throw new RuntimeException('XLSX có quá nhiều dòng.');$out=[];
        foreach($rows[1] as $rowXml){preg_match_all('/<c\b([^>]*)>(.*?)<\/c>/su',$rowXml,$cells,PREG_SET_ORDER);$row=[];foreach($cells as $c){$attrs=$c[1];$inner=$c[2];preg_match('/\br="([A-Z]+)\d+"/',$attrs,$rm);$col=self::colIndex($rm[1]??'A');if($col>=self::MAX_COLUMNS)continue;$type='';if(preg_match('/\bt="([^"]+)"/',$attrs,$tm))$type=$tm[1];$value='';if($type==='inlineStr'&&preg_match('/<t[^>]*>(.*?)<\/t>/su',$inner,$vm))$value=html_entity_decode(strip_tags($vm[1]),ENT_QUOTES|ENT_XML1,'UTF-8');elseif(preg_match('/<v[^>]*>(.*?)<\/v>/su',$inner,$vm)){$raw=html_entity_decode(strip_tags($vm[1]),ENT_QUOTES|ENT_XML1,'UTF-8');$value=$type==='s'?(string)($shared[(int)$raw]??''):$raw;}while(count($row)<$col)$row[]='';$row[$col]=$value;}ksort($row);$out[]=array_values($row);}return $out;
    }
    private static function colIndex(string $letters): int {$n=0;foreach(str_split($letters) as $ch)$n=$n*26+(ord($ch)-64);return max(0,$n-1);}
}
