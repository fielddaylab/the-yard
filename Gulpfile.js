var gulp = require('gulp');
var sass = require('gulp-sass');
var browserSync = require('browser-sync').create();

gulp.task('styles', function (){
  gulp.src('./assets/scss/styles.scss')
    .pipe(sass())
    .pipe(gulp.dest('./assets/css'))
    .pipe(browserSync.reload({stream: true}));
});

gulp.task('serve', function () {

  browserSync.init({
    server: {
      baseDir: './'
    }
  });

  gulp.watch('./assets/scss/*scss', ['styles']);
  gulp.watch('./**/*.html').on('change', browserSync.reload);

});

gulp.task('default', ['styles', 'serve']);
