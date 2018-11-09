#!/bin/bash

composerDownload(){
    if [ -f "composer.json" ]
    then
        echo Start composer download
        if [ -f "composer.phar" ]
        then
            echo "composer.phar has been exist."
        else
            curl -sS https://getcomposer.org/installer | php
            echo Composer download success
        fi
    else
        echo The project does not contain composer.json, so you dont need download composer.phar
    fi
}

composerInstall(){
    if [ -f "composer.json" ]
    then
        #    rm -r -f vendor
        #    rm -r -f composer.lock
        composer install
    else
        echo The project does not contain composer.json, so you dont need do composer.phar install
    fi
}

composerUpdate(){
    if [ -f "composer.json" ]
    then
        #    rm -r -f vendor
        #    rm -r -f composer.lock
        composer update
    else
        echo The project does not contain composer.json, so you dont need do composer.phar install
    fi
}


calcBranch(){
	case $1 in
	sandbox)
        	echo sandbox
	;;
	production)
        	echo production
	;;
	*)
        	echo sandbox
	;;
	esac
}

pull_web_source(){
    echo
    echo do git pull $1
    echo
    git reset --hard
    git pull

    BRANCH=`calcBranch $1`

    exists=`git show-ref refs/heads/$BRANCH`
    if [ -n "$exists" ]; then
        echo $BRANCH branch exists!
    else
        git checkout -b $BRANCH origin/$BRANCH
    fi
    git checkout $BRANCH
    git pull
    echo
    echo git pull web success
    echo
}
