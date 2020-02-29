#!/bin/bash
yum update -y
amazon-linux-extras install php7.2 -y 
yum install httpd -y
cd /var/www/html
wget https://wordpress.org/wordpress-5.3.2.tar.gz
tar -xzf wordpress-5.3.2.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.3.2.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
chkconfig httpd on
service httpd start
cat << EOF > /var/www/html/wp-config.php
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '${ name_db_instance }' );

/** MySQL database username */
define( 'DB_USER', '${ username }' );

/** MySQL database password */
define( 'DB_PASSWORD', '${ password }' );

/** MySQL hostname */
define( 'DB_HOST', '${ db-endpoint }' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'd{&|Le?rSJ_U{_[r}zXMUVL%&+qI*~>j(~rU68b:~uXm?qi0@u^H5y(u<RPV:?0L' );
define( 'SECURE_AUTH_KEY',  'dkIT0$]NJ{Gq5+J1fK(Cusf|z*Jm4oFHMKCh7EgY,%a:RxIRByH3[IQ=%hb?jnt-' );
define( 'LOGGED_IN_KEY',    'c7E}TIX@2>s5X ^+iW%JvK,[T& ;O$LCF^6af{0Pg|Wc}:Dv9HYvrl6Rm%>O7,oE' );
define( 'NONCE_KEY',        ')Mk?v>TT,~m!.;x5t{Hmox#mYLTs=Os>yQBje:AA4`h1VvkPAj*D|l+2?t?j-jqA' );
define( 'AUTH_SALT',        '<I0N8}8de!}d<yB|; P&:=T^UX|7q7sETq ID!.FynA3/ PAmtkbC.I_3Vbj}HT)' );
define( 'SECURE_AUTH_SALT', ' K15&)7{o=cJ!g!z HYahRNQk6%;7an/LLrx%dsFt;WtR{H+`n1vzwZUA0oxlWM(' );
define( 'LOGGED_IN_SALT',   'q#5% z2ebQ1Isct8%Vg9An:IY86q8PIQ3o,uX%*a$+E{wC6RdM>;p;q[O++xoWCN' );
define( 'NONCE_SALT',       'VeZ{n V;3:Hb r|i-ym^R/RbN=615:GICb[zy<y[dSoQ?,{ay{qJ6#YKNMVJc_##' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
\$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );

EOF