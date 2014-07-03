class Line < ActiveRecord::Base
  def self.create_from_input(text, time_limit)
    matches = text.scan(/^\[(\d+\/\d+\/\d+\s\d+:\d+:\d+\s.M)\]\s(.+?):\s(.*)$/)
    if matches.length > 0
      sections = matches[0]
      if sections.length == 3
        # Looks like we have a new line of chat
        # if it's newer than our time limit, write it in
        line_time = DateTime.strptime(sections[0],'%m/%d/%Y %I:%M:%S %p')
        Line.create(  speaker: sections[1],
                      content: sections[2],
                      created_at: line_time) unless line_time < time_limit
      end
    else
      # Continuation of the old line
      last_line = Line.last
      if last_line
        last_line.content = last_line.content + "\n" + text
        last_line.save
      end
    end
  end
end
