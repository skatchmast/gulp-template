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
    rename 			= require( 'gulp-rename' ),
//     rimraf 			= require( 'rimraf' ),
    run 			= require( 'run-sequence' ),
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
 * @task
 ************************************************************/
gulp.task( 'js:dev' ,( ) => {

    return gulp.src( conf.script )

        .pipe( plumber() )
        .pipe( coffee( { bare: true } ) )
        // .pipe( concat('app.js') )
        .pipe( babel( conf.presets ) )
        .pipe( prettify() )
        .pipe( gulp.dest( conf.build.script ) )

//  End js dev task
} );


gulp.task( 'js:prod' ,( ) => {

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

gulp.task('watch', ( ) => {
    gulp.watch( './source/**/*.*', gulp.series('js:dev') );
});

gulp.task('serve', ( ) => {

    webserver.init({
        server: "./"
    });

    gulp.watch('./build/**/*.*').on('change', webserver.reload);
    gulp.watch("./*.html").on('change', webserver.reload)
});

//  task default
gulp.task('default', gulp.parallel('watch', 'serve') );