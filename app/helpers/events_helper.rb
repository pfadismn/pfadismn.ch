module EventsHelper
  def event_place(place, place_description, sep = ', ')
    safe_join([
      (link_to(place, place) if place),
      place_description
  ].reject(&:blank?), sep)
  end
end
