# Infinite Coast 

A simple command-line and web interface to generate Dungeons & Dragons arena scenarios.

# Usage
Visit https://infinite-coast-44183.herokuapp.com/

*Here are the steps to get a local version running.*
1. Clone this project (`git clone https://github.com/vinleclair/infinite-coast && cd infinite-coast`)
2. Install dependencies (`mix deps.get && (cd assets && npm install)`)
3. Change PSQL credentials (`vim -O config/dev.exs config/test.exs`)
4. Create database (`mix ecto.create && mix ecto.migrate`)
5. Run! (`mix phx.server`)
