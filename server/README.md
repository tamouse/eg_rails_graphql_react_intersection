# README

Rails app implementing the canonical "mini-blogger" site with users, posts, and comments.

## Installation ##

### Prerequesites ###

* Postgresql. On Mac: `brew install postgresql` (Version doesn't matter so much, probably anyting >= 9.2)

### Setup ###

* Run the setup script: `./scripts/setup.sh`


## Development Steps ##

- [x] integrate bootstrap
- [x] User model, sign up
- [x] Sessions, log in, log out
- [x] set up authorization with Pundit
- [ ] Posts model
- [ ] Root page shows public (published) Posts
- [ ] Comments model
