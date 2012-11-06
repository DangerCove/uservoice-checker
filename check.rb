#!/usr/bin/env ruby

require 'yaml'
require 'uservoice-ruby'

sites = YAML.load_file('./sites.yml')

def command?(name)
  `which #{name}`
  $?.success?
end

output = ""

sites.each do |key, site|
  client = UserVoice::Client.new(site["domain"], site["api_key"], site["api_secret"], :callback => site["callback_url"])

  tickets = client.get("/api/v1/tickets.json?state=open&per_page=100")

  open_tickets = 0
  open_ticket_ids = []
  tickets["tickets"].each do |ticket|
    if ticket["messages"].first["is_admin_response"] == false
      open_tickets += 1
      open_ticket_ids << ticket["ticket_number"]
    end
  end

  if open_tickets > 0 or ARGV[0] == "d"
    unless ARGV[0] == "c"
      if command?("terminal-notifier")
        loc = `which terminal-notifier`.strip
        `#{loc} -title #{site["domain"]} -group uservoice -message "Open tickets: #{open_tickets}\n#{open_ticket_ids}" -notify com.apple.safari -open https://#{site["domain"]}.uservoice.com/admin/tickets`
      elsif command?("growlnotify")
        loc = `which growlnotify`.strip
        `#{loc} -m "Tickets #{site["domain"]}: #{open_tickets}\n#{open_ticket_ids}"`
      else
        output += "#{site["domain"]}: #{open_tickets} #{open_ticket_ids}\n"
      end
    else
      output += "#{site["domain"]}: #{open_tickets} #{open_ticket_ids}\n"
    end
  end
end

if ARGV[0] == "c"
  puts output
end

exit
