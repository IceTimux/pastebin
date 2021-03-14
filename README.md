# pastebin
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/IceTimux/pastebin)

A minimalist online pastebin created to be easily deployed to Heroku.

## Installation
Press the Deploy to Heroku button.

## Updating

1. Install the Heroku CLI
2. Login to Heroku
```
heroku login
```
3. Create a local git repository with the same name as your heroku app
```
cd myproject/
git init
```
4. Add Heroku and Github repository as remote / origin
```
heroku git:remote -a myproject
git remote add origin https://github.com/IceTimux/pastebin
```
5. Pull, commit and push to Heroku
```
git pull origin master
git add .
git commit -am "updating..."
git push heroku master
```
