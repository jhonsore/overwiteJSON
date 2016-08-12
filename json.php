<?php
$person_info = array(
    "name" => "lorem ipsum",
    "age" => 22,
    "occupation" => "Webmaster",
    "city" => utf8_encode("Vitória"),
    "interests" => array(utf8_encode("web"), utf8_encode("ios"), "HTML/CSS")
);

$json = json_encode($person_info);

echo $json;
?>