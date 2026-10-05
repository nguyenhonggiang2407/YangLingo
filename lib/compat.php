<?php
if(!function_exists('array_is_list')){function array_is_list(array $values): bool{$expected=0;foreach($values as $key=>$_){if($key!==$expected++)return false;}return true;}}
if(!function_exists('mb_strlen')){function mb_strlen(string $s,?string $enc=null): int{return strlen($s);}}
if(!function_exists('mb_substr')){function mb_substr(string $s,int $start,?int $length=null,?string $enc=null): string{return $length===null?substr($s,$start):substr($s,$start,$length);}}
if(!function_exists('mb_strtolower')){function mb_strtolower(string $s,?string $enc=null): string{return strtolower($s);}}
