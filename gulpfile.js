'use strict';
/**
 * Сonnection of all main plugins
 * @gulp
 ************************************************************/

const
//  Global plugins
    gulp        	= require( 'gulp' ),
    fs 				= require( 'fs' ),
    web	            = require( 'browser-sync' ),

//  More plugins ALL
    rename 			= require( 'gulp-rename' ),
//     rimraf 			= require( 'rimraf' ),
    plumber 	  	= require( 'gulp-plumber' ),
    concat 	  	    = require( 'gulp-concat' ),


//  More plugins CSS

//     autoprefixer     = require( 'gulp-autoprefixer' ),
//     cssbeautify   	= require( 'gulp-cssbeautify' ),
//     cssnano 		    = require( 'gulp-cssnano' ),
//     removeComments 	= require( 'gulp-strip-css-comments' ),
//     gcmq          	= require( 'gulp-group-css-media-queries' ),

//  More plugins JS
    prettify 		= require( 'gulp-jsbeautifier' ),
    babel 			= require( 'gulp-babel' ),
    uglify 			= require( 'gulp-uglify' ),

//  Preprocessors for compile
    sass  			= require( 'gulp-sass' ),
    coffee 			= require( 'gulp-coffee' ),

// Сonnection configurations
    conf			= require( 'js-yaml' ).safeLoad( fs.readFileSync( './conf.yaml' ,'utf8' ) ,{ json: true } );




/**
 * Assignment of main
 * @preprocessors tasks scripts
 ************************************************************/
gulp.task( 'script:dev' ,( ) => {

    return gulp.src( conf.script )

        .pipe( plumber() )
        .pipe( coffee( { bare: true } ) )
        // .pipe( concat('app.js') )
        .pipe( babel( conf.presets ) )
        .pipe( prettify() )
        .pipe( gulp.dest( conf.build.script ) )
        .pipe( web.stream() )

//  End js dev task
} );


gulp.task( 'script:prod' ,( ) => {

    return gulp.src( conf.script )

        .pipe( plumber() )
        .pipe( coffee( { bare: true } ) )
        // .pipe( concat('app.js') )
        .pipe( babel( conf.presets ) )
        .pipe( uglify() )
        .pipe( rename( conf.rename ) )
        .pipe( gulp.dest( conf.build.script ) )

//  End js prod task
} );




/**
 * Assignment of main
 * @preprocessors tasks styles
 ************************************************************/
gulp.task( 'style:dev' ,( ) => {

    return gulp.src( conf.style )

        .pipe( plumber() )
        .pipe( sass() )
        .pipe( gulp.dest( conf.build.style ) )
        .pipe( web.stream() )

//  End js dev task
} );




/**
 * Assignment of main
 * @preprocessors watch
 ************************************************************/
gulp.task('watch', ( ) => {
    gulp.watch( conf.script, gulp.series('script:dev') );
    gulp.watch( conf.style, gulp.series('style:dev') );
    /* HTML file reload */
    gulp.watch( './*.html' ).on('change', web.reload );
});




/**
 * Browser-sync of refresh
 * @open server
 ************************************************************/
gulp.task('web', ( ) => { web.init( conf.refresh ) });




/**
 * Assignment of main
 * @default task
 ************************************************************/
gulp.task('default', gulp.parallel( conf.tasksList ) );