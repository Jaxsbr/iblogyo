#!/bash/bin

hexo g

hexo d

cd ../../

git add .

git commit m 'update'

git push