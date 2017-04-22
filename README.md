Kamila's Git Hooks
==================

[Git hooks](http://githooks.com/) enable you to do things when something happens in a Git repo. My favorite use is "push to deploy": when I push new commits to a server, it will compile the thing and deploy a new version into production. Therefore:

- finding out what is deployed in production is trivial
- deploying a new release is trivial
  - and therefore there is little incentive to do horrible things like ssh-ing into prod and hotfixing things there :-)

I use it everywhere, because I have made it trivial to set up by writing it down :-)

How to
------

### [on server] set up repo:

```sh
# on server
cd _git  # I keep all my bare repos here
git clone --bare <url>  # if it's not there yet
cd <repo>/hooks
ln -s ../../git-hooks/post-receive-<something> ./post-receive
vim ./build.sh  # maybe -- see post-receive-<something>
# in my case, probably ln -s ../../git-hooks/examples/<repo>/build.sh .
```

### [in work repo] set up remote:

```sh
git remote add <name> ssh://kamila@<server>/home/kamila/_git/<repo>.git
```
Now you can type `git push <name> master` and watch your build/deploy :-)

Optionally, set up an "all" remote to push to everything at once:

```sh
git remote add all <fetch-url>
# for fish
for url in (git remote -v | cut -f2 | cut -d' ' -f1 | sort | uniq); git remote set-url --add --push all $url ; end
# for POSIX (bash, etc.)
for url in $(git remote -v | cut -f2 | cut -d' ' -f1 | sort | uniq); do git remote set-url --add --push all $url ; done
```

If you want to, set upstream to the `all` remote, so that you can `git push` there by default (for pull, `<fetch-url>` will be used):
```sh
git push -u all
```

"What to" / what useful things are in this repo
-----------------------------------------------

- `post-receive-clone-and-build`: Clones the repo into a temporary location and calls a custom script in there. Drop a `build.sh` next to `post-receive` (into `hooks/`). Example build scripts:
  - [Jekyll](https://jekyllrb.com/) website: [`examples/kamila.is/build.sh`](https://github.com/AnotherKamila/git-hooks/blob/master/examples/kamila.is/build.sh) (see https://github.com/AnotherKamila/kamila.is/tree/master/_bin for the actual scripts, which you probably want to copy as well). Mimics GitHub pages, except that it gives you more freedom :-)
  - Javascript single-page web application that uses npm (built with webpack): [`examples/songbook-web/build.sh`](https://github.com/AnotherKamila/git-hooks/blob/master/examples/songbook-web/build.sh)
  - Python web service (supervised by daemontools): [`examples/songbook-api/*`](https://github.com/AnotherKamila/git-hooks/blob/master/examples/songbook-api/)
