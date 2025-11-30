CREATE TABLE AirlineType (
  TypeID INT PRIMARY KEY,
  TypeName VARCHAR(255)
);

CREATE TABLE AirlineStatus (
  StatusID INT PRIMARY KEY,
  StatusName VARCHAR(255)
);

CREATE TABLE AircraftStatus (
  StatusID INT PRIMARY KEY,
  StatusName VARCHAR(255)
);

CREATE TABLE Airport (
  AirportID INT PRIMARY KEY,
  Name VARCHAR(255),
  City VARCHAR(255),
  Country VARCHAR(255),
  IATA VARCHAR(10),
  ICAO VARCHAR(10),
  Latitude DECIMAL(10,6),
  Longitude DECIMAL(10,6),
  LaunchDate DATE
);

CREATE TABLE Runway (
  RunwayID INT PRIMARY KEY,
  AirportID INT,
  Length INT,
  Surface VARCHAR(255),
  Orientation VARCHAR(255),
  FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

CREATE TABLE Airline (
  AirlineID INT PRIMARY KEY,
  Name VARCHAR(255),
  IATA VARCHAR(10),
  ICAO VARCHAR(10),
  TypeID INT,
  StatusID INT,
  RegionID INT,
  HomebaseAirportID INT,
  StockSymbol VARCHAR(255),
  LaunchDate DATE,
  ClosureDate DATE,
  FOREIGN KEY (TypeID) REFERENCES AirlineType(TypeID),
  FOREIGN KEY (StatusID) REFERENCES AirlineStatus(StatusID),
  FOREIGN KEY (HomebaseAirportID) REFERENCES Airport(AirportID)
);

CREATE TABLE Alliance (
  AllianceID INT PRIMARY KEY,
  Name VARCHAR(255),
  LaunchDate DATE
);

CREATE TABLE AirlineAlliance (
  AirlineID INT,
  AllianceID INT,
  JoinDate DATE,
  LeaveDate DATE,
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
  FOREIGN KEY (AllianceID) REFERENCES Alliance(AllianceID)
);

CREATE TABLE AirlineHierarchy (
  ParentAirlineID INT,
  SubsidiaryAirlineID INT,
  StartDate DATE,
  EndDate DATE,
  FOREIGN KEY (ParentAirlineID) REFERENCES Airline(AirlineID),
  FOREIGN KEY (SubsidiaryAirlineID) REFERENCES Airline(AirlineID)
);

CREATE TABLE AirlineFinancials (
  AirlineID INT,
  Year INT,
  PassengerNumbers INT,
  Revenue DECIMAL(18,2),
  ProfitLoss DECIMAL(18,2),
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID)
);

CREATE TABLE Aircraft (
  AircraftID INT PRIMARY KEY,
  Manufacturer VARCHAR(255),
  Model VARCHAR(255),
  SerialNumber VARCHAR(255),
  MSN VARCHAR(255),
  FirstFlightDate DATE,
  Age INT,
  MTOW INT,
  SeatConfig VARCHAR(255),
  EngineDetails VARCHAR(255),
  StatusID INT,
  FOREIGN KEY (StatusID) REFERENCES AircraftStatus(StatusID)
);

CREATE TABLE FleetAssignment (
  AirlineID INT,
  AircraftID INT,
  StartDate DATE,
  EndDate DATE,
  LeaseType VARCHAR(255),
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
  FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);

CREATE TABLE AircraftUtilisation (
  AircraftID INT,
  Year INT,
  FlightHours INT,
  FlightCycles INT,
  AvgStageLength INT,
  FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);

CREATE TABLE AircraftOrders (
  OrderID INT PRIMARY KEY,
  AirlineID INT,
  AircraftModel VARCHAR(255),
  OrderDate DATE,
  DeliveryDate DATE,
  Status VARCHAR(255),
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID)
);

CREATE TABLE Contact (
  ContactID INT PRIMARY KEY,
  Name VARCHAR(255),
  Email VARCHAR(255),
  LinkedIn VARCHAR(255),
  JobTitle VARCHAR(255)
);

CREATE TABLE ContactAssignment (
  ContactID INT,
  AirlineID INT,
  AirportID INT,
  StartDate DATE,
  EndDate DATE,
  FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
  FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

CREATE TABLE ExecutiveMovement (
  MovementID INT PRIMARY KEY,
  ContactID INT,
  Type VARCHAR(255),
  Date DATE,
  FOREIGN KEY (ContactID) REFERENCES Contact(ContactID)
);

CREATE TABLE Route (
  RouteID INT PRIMARY KEY,
  OriginAirportID INT,
  DestinationAirportID INT,
  Distance INT,
  Type VARCHAR(255),
  FOREIGN KEY (OriginAirportID) REFERENCES Airport(AirportID),
  FOREIGN KEY (DestinationAirportID) REFERENCES Airport(AirportID)
);

CREATE TABLE AirlineRoute (
  AirlineID INT,
  RouteID INT,
  AllianceID INT,
  AircraftTypeID INT,
  CodeshareWithAirlineID INT,
  WetLeaseAirlineID INT,
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
  FOREIGN KEY (RouteID) REFERENCES Route(RouteID),
  FOREIGN KEY (AllianceID) REFERENCES Alliance(AllianceID),
  FOREIGN KEY (AircraftTypeID) REFERENCES Aircraft(AircraftID),
  FOREIGN KEY (CodeshareWithAirlineID) REFERENCES Airline(AirlineID),
  FOREIGN KEY (WetLeaseAirlineID) REFERENCES Airline(AirlineID)
);

CREATE TABLE FlightSchedule (
  ScheduleID INT PRIMARY KEY,
  RouteID INT,
  AirlineID INT,
  DepartureTime TIME,
  ArrivalTime TIME,
  Frequency VARCHAR(255),
  Terminal VARCHAR(255),
  FOREIGN KEY (RouteID) REFERENCES Route(RouteID),
  FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID)
);

CREATE TABLE FlightCapacity (
  ScheduleID INT,
  AircraftID INT,
  SeatCapacity INT,
  SeatDensity VARCHAR(255),
  FOREIGN KEY (ScheduleID) REFERENCES FlightSchedule(ScheduleID),
  FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);

CREATE TABLE FlightEmissions (
  ScheduleID INT,
  CO2Emissions DECIMAL(18,2),
  FuelBurnRate DECIMAL(18,2),
  FOREIGN KEY (ScheduleID) REFERENCES FlightSchedule(ScheduleID)
);
