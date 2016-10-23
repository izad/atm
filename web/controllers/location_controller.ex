defmodule Atm.LocationController do
  use Atm.Web, :controller

  alias Atm.Location

  def index(conn, %{"lat" => lat, "lng" => lng}) do
  point = %Geo.Point{coordinates: {String.to_float(lat), String.to_float(lng)}, srid: 4326}

# CREATE EXTENSION postgis;
    locations = Repo.all from(l in Location,

      order_by: fragment("st_distance_sphere(st_makepoint(?, ?), st_makepoint(?, ?)) ASC", ^String.to_float(lat), ^String.to_float(lng), l.lat, l.lng),
      #select: {l, fragment("ST_distance_sphere(?,?)", ^%Geo.Point{coordinates: {l.lat, l.lng}, srid: 4326}, ^point)},
      #order_by: fragment("ST_distance_sphere(?,?)", ^%Geo.Point{coordinates: {l.lat, l.lng}, srid: 4326}, ^point),
      preload: [:bank],
      limit: 30
    )

  #  where: fragment("ST_distance_sphere(?,?)", place.location, ^point) >= ^distance,
  #order_by: fragment("ST_distance_sphere(?,?)", place.location, ^point),
  #select: {place, fragment("ST_distance_sphere(?,?)", place.location, ^point)}

    render(conn, "index.json", locations: locations)
  end
end
