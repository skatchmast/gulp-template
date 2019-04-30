'use strict';
/**
 * Сonnection of all main plugins
 * @gulp
 ************************************************************/

const
//  Global plugins
    gulp        	= require( 'gulp' ),
    fs 				= require( 'fs' ),
    webserver	    = require( 'browser-sync' ),

//  More plugins ALL
//     rename 			= require( 'gulp-rename' ),
//     rimraf 			= require( 'rimraf' ),
//     run 			= require( 'run-sequence' ),
    plumber 	  	= require( 'gulp-plumber' ),

//  More plugins CSS

//     autoprefixer    = require( 'gulp-autoprefixer' ),
//     cssbeautify   	= require( 'gulp-cssbeautify' ),
//     cssnano 		= require( 'gulp-cssnano' ),
//     removeComments 	= require( 'gulp-strip-css-comments' ),
//     gcmq          	= require( 'gulp-group-css-media-queries' ),

//  More plugins JS
    prettify 		= require( 'gulp-jsbeautifier' ),
    babel 			= require( 'gulp-babel' ),
//     browserify 		= require( 'gulp-browserify' ),
//     uglify 			= require( 'gulp-uglify' ),

//  Preprocessors for compile
    sass  			= require( 'gulp-sass' ),
    coffee 			= require( 'gulp-coffee' ),

// Сonnection configurations
    conf			= require( 'js-yaml' ).safeLoad( fs.readFileSync( './conf.yaml' ,'utf8' ) ,{ json: true } );




/**
 * Assignment of main task
 * @build
 ************************************************************/
gulp.task( 'js:dev' ,( ) => {

    return gulp.src( conf.script )

        .pipe( plumber() )
        .pipe( coffee( { bare: true } ) )
        .pipe( babel( conf.presets ) )
        .pipe( prettify() )
        .pipe( gulp.dest( conf.build.script ) )

//  End js dev task
} );


gulp.task( 'js:prod' ,( ) => {

    return gulp.src( conf.script )

        .pipe( plumber() )
        .pipe( coffee( { bare: true } ) )
        .pipe( babel( conf.presets ) )
        .pipe( uglify() )
        .pipe( rename( conf.opion.rename ) )
        .pipe( gulp.dest( conf.build.script ) )

//  End js prod task
} );