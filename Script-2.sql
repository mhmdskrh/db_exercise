create table Customer (
	CustomerId serial primary key,
	FirstName varchar,
	LastName varchar,
	Email varchar,
	Phone varchar,
	CreatedAt timestamp	
);

create table Branch (
	BranchId serial primary key,
	Name varchar,
	Address varchar,
	City varchar
);

create table Category (
	CategoryId serial primary key,
	Name varchar
);

create table Product (
	ProductId serial primary key,
	CategoryId int /*references Category(CategoryId)*/,
	Name varchar,
	Brand varchar,
	Model varchar,
	CurrentDailyRate varchar,
	IsActive bool	
);

create type OperationalStatus as enum ('AVAILABLE', 'MAINTENANCE',
'DAMAGED', 'RETIRED');

create table EquipmentUnit (
	EquipmentUnitId serial primary key,
	ProductId int /*references Product(ProductId)*/,
	BranchId int /*references Branch(BranchId)*/,
	SerialNumber varchar,
	AssetCode varchar,
	OperationalStatus OperationalStatus,
	PurchaseDate timestamp,
	IsActive bool
);

create table Reservation (
	ReservationId serial primary key, 
	CustomerId int /*references Customer(CustomerId)*/,
	BranchId int /*references Branch(BranchId)*/,
	StartDate timestamp,
	EndDate timestamp,
	Status varchar,
	CreatedAt timestamp
);

create table ReservationItem (
	ReservationItemId serial primary key,
	ReservationId int /*references Reservation(ReservationId)*/,
	ProductId int /*references Product(ProductId)*/,
	Quantity int,
	AgreedDailyRate Decimal
);

create table ReservationUnit (
	ReservationItemId int /*references ReservationItem(ReservationItemId)*/,
	EquipmentUnitId int /*references EquipmentUnit(EquipmentUnitId)*/,
	AssignedAt timestamp
);

create table Payment (
	PaymentId serial primary key,
	ReservationId int references Reservation(ReservationId),
	Amount int,
	PaymentDate timestamp,
	PaymentMethod varchar,
	Status varchar,
	Reference varchar
);

create table Maintenance (
	MaintenanceId serial primary key,
	EquipmentUnitId int references EquipmentUnit(EquipmentUnitId),
	StartDate timestamp,
	EndDate timestamp,
	Description varchar,
	cost Decimal,
	Status varchar
);

create table EquipmentTransfer (
	TransferId serial primary key,
	EquipmentUnitId int /*references EquipmentUnit(EquipmentUnitId)*/,
	FromBranchId int /*references Branch(BranchId)*/,
	ToBranchId int /*references Branch(BranchId)*/,
	TransferDate timestamp
);

ALTER TABLE Product ADD CONSTRAINT ctgfk FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId);

ALTER TABLE EquipmentUnit ADD CONSTRAINT prdfk FOREIGN KEY (ProductId) REFERENCES Product(ProductId);
ALTER TABLE EquipmentUnit ADD CONSTRAINT brnchfk FOREIGN KEY (BranchId) REFERENCES Branch(BranchId);

ALTER TABLE Reservation ADD CONSTRAINT cusfk FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId);
ALTER TABLE Reservation ADD CONSTRAINT brnchfk FOREIGN KEY (BranchId) REFERENCES Branch(BranchId);

ALTER TABLE ReservationItem ADD CONSTRAINT rsrvfk FOREIGN KEY (ReservationId) REFERENCES Reservation(ReservationId);
ALTER TABLE ReservationItem ADD CONSTRAINT prdfk FOREIGN KEY (ProductId) REFERENCES Product(ProductId);

ALTER TABLE ReservationUnit ADD CONSTRAINT rsrvitmfk FOREIGN KEY (ReservationItemId) REFERENCES ReservationItem(ReservationItemId);
ALTER TABLE ReservationUnit ADD CONSTRAINT equntfk FOREIGN KEY (EquipmentUnitId) REFERENCES EquipmentUnit(EquipmentUnitId);

ALTER TABLE Payment ADD CONSTRAINT rsrvfk FOREIGN KEY (ReservationId) REFERENCES Reservation(ReservationId);

ALTER TABLE Maintenance ADD CONSTRAINT equntfk FOREIGN KEY (EquipmentUnitId) REFERENCES EquipmentUnit(EquipmentUnitId);

ALTER TABLE EquipmentTransfer ADD CONSTRAINT equntfk FOREIGN KEY (EquipmentUnitId) REFERENCES EquipmentUnit(EquipmentUnitId);
ALTER TABLE EquipmentTransfer ADD CONSTRAINT brnchfk FOREIGN KEY (FromBranchId) REFERENCES Branch(BranchId);
ALTER TABLE EquipmentTransfer ADD CONSTRAINT tobrnchfk FOREIGN KEY (ToBranchId) REFERENCES Branch(BranchId);