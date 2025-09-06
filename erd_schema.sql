

Table Airline {
  AirlineID int [pk]
  Name varchar
  IATA varchar
  ICAO varchar
  TypeID int [ref: > AirlineType.TypeID]
  StatusID int [ref: > AirlineStatus.StatusID]
  RegionID int
  HomebaseAirportID int [ref: > Airport.AirportID]
  StockSymbol varchar
  LaunchDate date
  ClosureDate date
}

Table AirlineType {
  TypeID int [pk]
  TypeName varchar
}

Table AirlineStatus {
  StatusID int [pk]
  StatusName varchar
}

Table Alliance {
  AllianceID int [pk]
  Name varchar
  LaunchDate date
}

Table AirlineAlliance {
  AirlineID int [ref: > Airline.AirlineID]
  AllianceID int [ref: > Alliance.AllianceID]
  JoinDate date
  LeaveDate date
}

Table AirlineHierarchy {
  ParentAirlineID int [ref: > Airline.AirlineID]
  SubsidiaryAirlineID int [ref: > Airline.AirlineID]
  StartDate date
  EndDate date
}

Table AirlineFinancials {
  AirlineID int [ref: > Airline.AirlineID]
  Year int
  PassengerNumbers int
  Revenue decimal
  ProfitLoss decimal
}

Table Aircraft {
  AircraftID int [pk]
  Manufacturer varchar
  Model varchar
  SerialNumber varchar
  MSN varchar
  FirstFlightDate date
  Age int
  MTOW int
  SeatConfig varchar
  EngineDetails varchar
  StatusID int [ref: > AircraftStatus.StatusID]
}

Table AircraftStatus {
  StatusID int [pk]
  StatusName varchar
}

Table FleetAssignment {
  AirlineID int [ref: > Airline.AirlineID]
  AircraftID int [ref: > Aircraft.AircraftID]
  StartDate date
  EndDate date
  LeaseType varchar
}

Table AircraftUtilisation {
  AircraftID int [ref: > Aircraft.AircraftID]
  Year int
  FlightHours int
  FlightCycles int
  AvgStageLength int
}

Table AircraftOrders {
  OrderID int [pk]
  AirlineID int [ref: > Airline.AirlineID]
  AircraftModel varchar
  OrderDate date
  DeliveryDate date
  Status varchar
}

Table Airport {
  AirportID int [pk]
  Name varchar
  City varchar
  Country varchar
  IATA varchar
  ICAO varchar
  Latitude decimal
  Longitude decimal
  LaunchDate date
}

Table Runway {
  RunwayID int [pk]
  AirportID int [ref: > Airport.AirportID]
  Length int
  Surface varchar
  Orientation varchar
}

Table Contact {
  ContactID int [pk]
  Name varchar
  Email varchar
  LinkedIn varchar
  JobTitle varchar
}

Table ContactAssignment {
  ContactID int [ref: > Contact.ContactID]
  AirlineID int [ref: > Airline.AirlineID]
  AirportID int [ref: > Airport.AirportID]
  StartDate date
  EndDate date
}

Table ExecutiveMovement {
  MovementID int [pk]
  ContactID int [ref: > Contact.ContactID]
  Type varchar
  Date date
}

Table Route {
  RouteID int [pk]
  OriginAirportID int [ref: > Airport.AirportID]
  DestinationAirportID int [ref: > Airport.AirportID]
  Distance int
  Type varchar
}

Table AirlineRoute {
  AirlineID int [ref: > Airline.AirlineID]
  RouteID int [ref: > Route.RouteID]
  AllianceID int [ref: > Alliance.AllianceID]
  AircraftTypeID int [ref: > Aircraft.AircraftID]
  CodeshareWithAirlineID int [ref: > Airline.AirlineID]
  WetLeaseAirlineID int [ref: > Airline.AirlineID]
}

Table FlightSchedule {
  ScheduleID int [pk]
  RouteID int [ref: > Route.RouteID]
  AirlineID int [ref: > Airline.AirlineID]
  DepartureTime time
  ArrivalTime time
  Frequency varchar
  Terminal varchar
}

Table FlightCapacity {
  ScheduleID int [ref: > FlightSchedule.ScheduleID]
  AircraftID int [ref: > Aircraft.AircraftID]
  SeatCapacity int
  SeatDensity varchar
}

Table FlightEmissions {
  ScheduleID int [ref: > FlightSchedule.ScheduleID]
  CO2Emissions decimal
  FuelBurnRate decimal
}
