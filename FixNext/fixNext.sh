#!/bin/bash
# ./fixNext.sh next_theme_dir
# for example put FixNext in hexo_dir and use: `FixNext/fixNext.sh themes/next`

# pull the lastest Next theme
# git clone https://github.com/theme-next/hexo-theme-next $1
rm -rf $1
git clone git@github.com:theme-next/hexo-theme-next.git $1
# git clone git@github.com:sli1989/hexo-theme-next.git themes/next

# auto install 3rd libs locally, use CDN verdor instead
# git clone https://github.com/theme-next/theme-next-pace $1/source/lib/pace
# git clone https://github.com/theme-next/theme-next-needmoreshare2 $1/source/lib/needsharebutton
# git clone https://github.com/theme-next/theme-next-reading-progress $1/source/lib/reading_progress
# git clone https://github.com/theme-next/theme-next-pangu.git $1/source/lib/pangu
# git clone https://github.com/theme-next/theme-next-bookmark.git $1/source/lib/bookmark

# replace symbol of tags
sed 's/rel="tag">#/rel="tag"><i class="fa fa-tag"><\/i>/' -i $1/layout/_macro/post.swig

# fix Categories meta
# replace
sed "s/__('post.in')/__('post.in') + __('symbol.colon')/" -i $1/layout/_macro/post.swig
# add behind the matching row
sed '/symbol.comma/a \                  <span> > <\/span>' -i $1/layout/_macro/post.swig
# delete the matching row
sed -i '/symbol.comma/d' $1/layout/_macro/post.swig

# added in v607
# Beat up the heart on the footer
# replace
# sed 's/"with-love"/"with-love" id="heart"/' -i $1/layout/_partials/footer.swig

# add footer_powered
# custom_text provided by next v6
# sed '/config.author }}<\/span>/r FixNext/footer_powered' -i $1/layout/_partials/footer.swig

# fix the dns of leancloud
# replace
# sed 's/https:\/\/cdn1.lncld.net\/static\/js\/av-core-mini-0.6.4.js/ \/static\/js\/av-core-mini-0.6.4.js/' -i $1/layout/_third-party/analytics/lean-analytics.swig

# Click on the site-author-image to return to the homepage
# add in front of the matching row
sed '/<img class="site-author-image"/i <a href="/" class="site-author-image" rel="start" style="border:none">' -i $1/layout/_macro/sidebar.swig
# add behind the matching row
sed '/alt="{{ theme.author }}" \/>/a </a>' -i $1/layout/_macro/sidebar.swig

# added in next
# auto spaceing using pangu.js 
# add in front of the matching row
# sed '/<\/head>/i <script src="https://cdnjs.cloudflare.com/ajax/libs/pangu/3.3.0/pangu.min.js"></script>' -i $1/layout/_layout.swig
# add in front of the matching row
# sed '/<\/body>/i <script>pangu.spacingPage();</script>' -i $1/layout/_layout.swig

# H5 music player
# add in front of the matching row
# Turn the command line into double quotes when you have single quotes
sed "/<\/body>/i {% include '_my/audio.swig' %}" -i $1/layout/_layout.swig
cp -a FixNext/QPlayer/_my $1/layout

# display Footnotes 
# add in front of the matching row
cp FixNext/custom.js $1/source/js
sed '/<\/body>/i <script type="text/javascript" src="/js/custom.js"></script>' -i $1/layout/_layout.swig

# fonts and hyperlinks styles
# Redefine custom file paths. Introduced in NexT v6.0.2.
# cp FixNext/custom1.styl $1/source/css/_variables/custom.styl
# cp FixNext/custom2.styl $1/source/css/_custom/custom.styl
# fix footer-height
# sed 's/$footer-height                  = 50px/$footer-height                  = 100px/' -i $1/source/css/_variables/base.styl

# add align=center in muse's post
# add behind the matching row
sed '/@import "sidebar\/sidebar-blogroll";/a @import "../Pisces/_posts";' -i $1/source/css/_schemes/Muse/index.styl

# add new indexpage
# add behind the matching row
sed '/commonweal/a \  hits: 热文\n  navi: 导航\n  comments: 留言板' -i $1/languages/zh-CN.yml
# fix Categories meta
# replace
sed "s/分类于/分类/" -i $1/languages/zh-CN.yml
# replace the zh-CN
# cp FixNext/zh-CN.yml $1/languages/zh-CN.yml

# delete words flashing in post-reward
# add in front of the matching row
sed '/#QR > div:hover/i /*' -i $1/source/css/_common/components/post/post-reward.styl
sed '/@keyframes roll/i */' -i $1/source/css/_common/components/post/post-reward.styl