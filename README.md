# ArenaGenerator

A simple command-line and web interface to generate Dungeons & Dragons arena scenarios.

# Usage
*This project is under heavy construction, here are the simple steps to get a working version running.*

1. Clone this project (`git clone https://github.com/BinaryTiger/a-a && cd a-a`)
2. Install dependencies (`mix deps.get && (cd assets && npm install)`)
3. Change PSQL credentials (`vim -O config/dev.exs config/test.exs`)
4. Create database (`mix ecto.create && mix ecto.migrate`)
5. Run! (`mix phx.server`)
