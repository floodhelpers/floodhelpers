# floodhelpers

We're putting a little web thing together to help direct volunteer efforts for the floods in Hebden Bridge and the Calder valley.

# Hosting

floodhelpers.org is hosted on AWS EC2 and run with Docker.

Pushing to Github master will deploy via Codeship

The repo lives in `/app`. Codeship SSHs in, pulls the repo and uses `docker-compose` to rebuild and restart the container.
`/craft/storage` is mounted as a volume so that it persists between restarts.

Email mike@mbfisher.com with your Github email address and/or public SSH key for access to Codeship and the EC2 instance.

Log in to the EC2 instance as the `ubuntu` user.

## Logs

Apache:

    cd /app
    sudo docker-compose logs
    
Craft:

    tail -f /craft/storage/runtime/logs/craft.log

# Craft

## Craft Docs

Installation instructions and much more.
https://craftcms.com/docs


## Craft Updates

Release notes with bug fixes, improvements and additions.
https://craftcms.com/updates


## Craft Stack Exchange

A great place to ask your Craft questions, meet the awesome Craft community and earn mad reputation.
https://craftcms.stackexchange.com/