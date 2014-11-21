<?php

//
// my2pg.sh
//

//$stdin = fgets( STDIN );

$str = '';
$table = '';

$flag = true;
$arr_index = array();
$arr_str = array();

while(( $line = fgets( STDIN, 4096 )) !== false ) {

    $line = str_replace( '`', '', $line );
    if( preg_match( '/CREATE TABLE (.+?) /', $line, $match )) {

        if( $flag === false ) {
            $str = convert( $str ); 
            $arr_str[] = $str;
            // initialize
            $str = '';
            $arr_index = array();
        }

        $flag = false;

        //var_dump( $match );
        $table = $match[1];
        //echo $table;
    }

    if( preg_match( '/^  *?KEY (.+?) \((.+?)\)/', $line, $match )) {
        //var_dump( $match );
        $arr_index[] = 'CREATE INDEX idx_' . $match[1]. ' ON ' . $table . ' (' . $match[2]. ');';
    //} else if( preg_match( '/PRIMARY KEY/', $line, $match )) {
    //    $line = str_replace( ',', '', $line );
    //    $str .= $line;
    } else {
        $str .= $line;
    }
}

$str = convert( $str ); 
$arr_str[] = $str;

function convert( $str ) {
    global $arr_index;
    $r = array( 
    '`'=>'',
    'ENGINE=InnoDB DEFAULT CHARSET=utf8'=>'',
    'COLLATE=utf8_unicode_ci'=>'',
    'COLLATE utf8_unicode_ci'=>'',
    'CHARACTER SET utf8'=>'',
    //'COMMENT'=>'--',

    'varchar'=>'character varying',
    'int(11) NOT NULL AUTO_INCREMENT' => 'serial',
    'int(11)' => 'integer',
    'datetime'=>'timestamp without time zone',
    'double'=>'double precision',
    'tinyint(4)'=>'integer',
    'mediumtext'=>'text',
    );

    $r_regex = array( 
        '/COMMENT.*,/'=>',',
    );

    foreach( $r as $k=>$v ) {
       $str = str_replace( $k, $v, $str );
    }

    foreach( $r_regex as $k=>$v ) {
       $str = preg_replace( $k, $v, $str );
    }

    // TODO
    //foreach( $arr_index as $index) {
    //    $str .= $index . "\n";
    //}

    return $str;
}


//var_dump( $arr_str );

foreach( $arr_str as $str ) {

    $str = preg_replace( "/,\s*\)\s*;/s", ' );', $str );
    echo $str . "\n";
}
