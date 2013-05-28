mainstuff: js presentation.html figs/manyboxplots.png figs/manyboxplots_oldschool.png figs/intercross.png

js: js/manyboxplots.js js/lod_and_effect.js js/cistrans.js

js/manyboxplots.js: coffee/manyboxplots.coffee
	coffee -co js coffee/manyboxplots.coffee

js/lod_and_effect.js: coffee/lod_and_effect.coffee
	coffee -co js coffee/lod_and_effect.coffee

js/cistrans.js: coffee/cistrans.coffee
	coffee -co js coffee/cistrans.coffee

figs/manyboxplots.png: R/hypo_boxplot.R
	cd R;R CMD BATCH hypo_boxplot.R

figs/manyboxplots_oldschool.png: R/hypo_boxplot_oldschool.R
	cd R;R CMD BATCH hypo_boxplot_oldschool.R

figs/intercross.png: R/intercross_fig.R
	cd R;R CMD BATCH intercross_fig.R

presentation.html: index.html js css/kbroman_talk.css css/kbroman_presentation.css
	Perl/create_presentation.pl

webmain:
	scp index.html presentation.html broman-2:public_html/presentations/CTC2013/

webcss:
	scp css/*.css broman-2:public_html/presentations/CTC2013/css/

webcode:
	scp js/*.js broman-2:public_html/presentations/CTC2013/js/
	scp coffee/*.coffee broman-2:public_html/presentations/CTC2013/coffee/

webdata:
	scp data/hypo.json data/insulinlod.json broman-2:public_html/presentations/CTC2013/data/

webfigs:
	scp figs/*.png broman-2:public_html/presentations/CTC2013/figs/

web: webmain webcss webcode webfigs webdata all

tar: mainstuff
	cd ..;tar czvf CTC2013.tgz CTC2013/*.html CTC2013/css CTC2013/coffee CTC2013/js CTC2013/data CTC2013/figs;mv CTC2013.tgz CTC2013/

all: js web presentation.html tar
