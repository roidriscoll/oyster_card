class JourneyLog

  def initialize
    @journeys = []
  end

  def start_journey(journey)
    @journeys << journey
  end

  def end_journey(exit_station)
    current_journey.end(exit_station)
  end

  def current_journey
    @journeys.last
  end

  # This is going to mess them up!
  def journeys
    @journeys.dup
  end

  def outstanding_charges
    incomplete_journeys
      .each(&:close)
      .map(&:fare)
      .reduce(&:+)
  end

  private

  def incomplete_journeys
    @journeys.reject(&:paid?)
  end

  attr_reader :journey_klass
end
