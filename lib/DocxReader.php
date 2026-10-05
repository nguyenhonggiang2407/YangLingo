<?php
final class DocxReader {
    private const MAX_XML_BYTES=10485760;
    public static function extractText(string $path): string {$xml=ZipReader::entry($path,'word/document.xml');if($xml===null)throw new RuntimeException('DOCX không hợp lệ hoặc không có word/document.xml.');if(strlen($xml)>self::MAX_XML_BYTES)throw new RuntimeException('DOCX có XML quá lớn.');$xml=preg_replace('/<w:tab[^>]*\/>/i',"\t",$xml);$xml=preg_replace('/<w:br[^>]*\/>/i',"\n",$xml);$xml=preg_replace('/<\/w:p>/i',"\n",$xml);$xml=preg_replace('/<\/w:tc>/i',"\t",$xml);$xml=preg_replace('/<\/w:tr>/i',"\n",$xml);$text=strip_tags($xml);$text=html_entity_decode($text,ENT_QUOTES|ENT_XML1,'UTF-8');$text=preg_replace("/\r\n|\r/","\n",$text);$text=preg_replace('/[ \t]+/u',' ',$text);$text=preg_replace('/\n{3,}/u',"\n\n",$text);return mb_substr(trim($text),0,4000000);}
}
