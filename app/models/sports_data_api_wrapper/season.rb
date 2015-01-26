module SportsDataApiWrapper
  class Season

    attr_reader :year, :season, :golfers

    def initialize(args = {})
      raise "Please pass a hash" unless args.is_a?(Hash)
      raise "You must provide a year" unless args[:year].present?
      @year = args[:year]
      @season = SportsDataApi::Golf.season(year)
      @golfers = SportsDataApi::Golf.players(year).players
    end

    def sync_to_db
      # season.tournaments.each do |api_tournament|
      #   return if Tournament.find_by_sports_data_api_id(api_tournament.id)
      #   create_tournament(api_tournament)
      # end
      create_players
    end

    private

      def create_tournament(api_tournament)
        venue = create_venue(api_tournament.venue)

        Tournament.create({
          sports_data_api_id: api_tournament.id,
          name: api_tournament.name,
          event_type: api_tournament.event_type,
          purse: api_tournament.purse,
          winning_share: api_tournament.winning_share,
          points: api_tournament.points,
          start_date: api_tournament.start_date,
          end_date: api_tournament.end_date,
          venue_id: venue.id,
          year: api_tournament.year,
          status: api_tournament.status,
          coverage: api_tournament.coverage
        })
      end

      def create_venue(api_venue)
        return if Venue.find_by_sports_data_api_id(api_venue.id)
        venue = Venue.create({
          sports_data_api_id: api_venue.id,
          name: api_venue.name,
          city: api_venue.city,
          state: api_venue.state,
          zipcode: api_venue.zipcode,
          country: api_venue.country
        })
        create_courses(api_venue.id, api_venue.courses)
        return venue
      end

      def create_courses(venue_id, api_courses)
        api_courses.each do |api_course|
          next if Course.find_by_sports_data_api_id(api_course.id)
          course = Course.create({
            sports_data_api_id: api_course.id,
            name: api_course.name,
            yardage: api_course.yardage,
            par: api_course.par,
            venue_id: venue_id
          })
          create_holes(course.id, api_course.holes)
        end
      end

      def create_holes(course_id, api_holes)
        api_holes.each do |api_hole|
          hole = Hole.create({
            course_id: course_id,
            number: api_hole.number,
            par: api_hole.par,
            yardage: api_hole.yardage
          })
        end
      end

      def create_players
        golfers.each do |api_player|
          next if Golfer.find_by_sports_data_api_id(api_player.id)
          statistics = api_player.statistics
          Golfer.create({
            # player profile
            sports_data_api_id: api_player.id,
            first_name: api_player.first_name,
            last_name: api_player.last_name,
            height: api_player.height,
            weight: api_player.weight,
            birthday: api_player.birthday,
            country: api_player.country,
            residence: api_player.residence,
            birth_place: api_player.birth_place,
            member: api_player.member,
            updated: api_player.updated,
            college: api_player.college,
            turned_pro: api_player.turned_pro,
            seed: api_player.seed,
            ball_maker: api_player.ball_maker,
            club_maker: api_player.club_maker
          }.merge(statistics_hash(statistics)))
        end
      end

      def statistics_hash(statistics)
        return {} unless statistics.present?
        {
          drive_avg: statistics.drive_avg,
          cuts_made: statistics.cuts_made,
          cuts: statistics.cuts,
          drive_acc: statistics.drive_acc,
          earnings_rank: statistics.earnings_rank,
          events_played: statistics.events_played,
          points_rank: statistics.points_rank,
          points: statistics.points,
          first_place: statistics.first_place,
          gir_pct: statistics.gir_pct,
          hole_proximity_avg: statistics.hole_proximity_avg,
          scoring_avg: statistics.scoring_avg,
          scrambling_pct: statistics.scrambling_pct,
          earnings: statistics.earnings,
          second_place: statistics.second_place,
          strokes_gained: statistics.strokes_gained,
          third_place: statistics.third_place,
          top_10: statistics.top_10,
          top_25: statistics.top_25,
          withdrawals: statistics.withdrawals,
          world_rank: statistics.world_rank
        }
      end

  end
end