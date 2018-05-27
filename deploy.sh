if [[ $TRAVIS_BRANCH != 'master' ]]; then
	exit
fi

openssl aes-256-cbc -K $encrypted_6cbafc8f61d3_key -iv $encrypted_6cbafc8f61d3_iv -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key
ssh -T git@github.com
git remote set-url origin git@github.com:HaxeFlixel/HaxeFlixel.com-demos.git
git config user.name 'Travis CI'
git config user.email '<>'
git add -A
git commit -m "Update binaries [skip ci]" --amend --date="$(date -R)"
git push origin -f