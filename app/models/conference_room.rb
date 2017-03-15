class ConferenceRoom

  CONFERENCE_ROOMS_AREAS = [
      { location: 'in the vendor conference area (off of reception)', rooms: ['fill their baskets', 'service selection price', 'man in the desert', 'air of excitement']},
      { location: 'in the Information Systems area', rooms: ['data central']},
      { location: 'at the north end of the Information Systems area', rooms: ['perfect product presentation', 'main and main']},
      { location: 'off the atrium, behind reception', rooms: ['1 great = 3 good', 'intuition does not come to an unprepared mind']},
      { location: "where gumby has always been located...c'mon!", rooms: ['gumby']},
      { location: 'upstairs, south end, adjacent to CSD', rooms: ['contain yourself']},
      { location: 'upstairs, south end, adjacent to CSD (seating area in front of Contain Yourself)', rooms: ['we love our employees']},
      { location: 'upstairs, southwest corner', rooms: ['all eyes on elfa']},
      { location: 'upstairs, southwest corner, adjacent to loss prevention', rooms: ['service = selling', 'fun and functional']},
      { location: 'upstairs, northwest corner, adjacent to the executive suite', rooms: ['communication is leadership']},
      { location: 'up the stairs, turn right (adjacent to merchandising)', rooms: ['we sell the hard stuff', 'blue sky']}
  ]

  # Could also make a hash with each individual room as a key. Depending on the size this could yield better performance
  # However, there would duplication when it comes to location. I choose approach because it represents the object clearly and limits duplication.

  def self.reply_for(query)
      area = CONFERENCE_ROOMS_AREAS.find{ |area| area[:rooms].include? query.downcase}
      area ? "#{query} is located #{area[:location]}" : "somewhere, but I don't know where"
  end

  def self.list_rooms
    conference_rooms = CONFERENCE_ROOMS_AREAS.flat_map{ |area| area[:rooms] }.map(&:titleize)
    # Limits each set to 160 charactes, which is the SMS limit
    char_limit_regex = /[\w, =]{1,160}(?:,|$)/
    conference_rooms.scan(char_limit_regex).map(&:strip)
  end
end