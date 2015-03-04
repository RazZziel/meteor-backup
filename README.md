Quick'n'dirty backup and restore scripts for Meteor sites.

Works for me (TM), but I take no responsability if it blows your data into oblivion.

Usage:

Backup the local database ("meteor" needs to be running)

	./backup

Backup a remote database

	./backup YOUR_SITE.meteor.com

Restore backup to a local database ("meteor" needs to be running)

	./restore BACKUP_DIRECTORY

Restore backup to a remote database

	./restore BACKUP_DIRECTORY YOUR_SITE.meteor.com
