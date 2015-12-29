<?php

/**
 * Database Configuration
 *
 * All of your system's database configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

return array(

  '*' => array(
    'tablePrefix' => 'craft',
  ),

  'dev' => array(
    'server' => 'localhost',
    'user' => 'root',
    'password' => 'root',
    'database' => 'floodhelpers',
  ),

  'live' => array(
    'server' => 'localhost',
		'user' => 'fccb4cd72216',
		'password' => '8dc1b2b7246953be',
		'database' => 'floodhelpers',
  )

);