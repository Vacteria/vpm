
-- -----------------------------------------------------
-- Table architecture
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS architecture (
  idArchitecture INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(45) NOT NULL,
   UNIQUE (name));


-- -----------------------------------------------------
-- Table type
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS type (
  idType INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(45) NOT NULL ,
  UNIQUE (idType) ,
  UNIQUE (name) );


-- -----------------------------------------------------
-- Table package
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS package (
  idPackage INTEGER PRIMARY KEY AUTOINCREMENT ,
  name VARCHAR(60) NOT NULL ,
  version VARCHAR(45) NOT NULL ,
  node VARCHAR(60) NOT NULL ,
  licences VARCHAR(45) NOT NULL ,
  idArchitecture INTEGER NOT NULL ,
  type_idType INTEGER NOT NULL ,
  UNIQUE (idPackage,name),
  CONSTRAINT fk_package_architecture1
    FOREIGN KEY (idArchitecture )
    REFERENCES architecture (idArchitecture )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_package_type1
    FOREIGN KEY (type_idType )
    REFERENCES type (idType )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table section
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS section (
  idSection INTEGER NOT NULL ,
  name VARCHAR(45) NOT NULL ,
  PRIMARY KEY (idSection) ,
  UNIQUE (name) );


-- -----------------------------------------------------
-- Table holdon
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS holdon (
  idHoldon INTEGER PRIMARY KEY AUTOINCREMENT ,
  name VARCHAR(45) NOT NULL ,
  UNIQUE (name) );


-- -----------------------------------------------------
-- Table packager
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS packager (
  idPackager INTEGER PRIMARY KEY AUTOINCREMENT ,
  name VARCHAR(45) NOT NULL ,
  nickname VARCHAR(45) NOT NULL ,
  email VARCHAR(200) NOT NULL ,
  UNIQUE (email) );


-- -----------------------------------------------------
-- Table typeDep
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS typeDep (
  idTypeDep INTEGER PRIMARY KEY AUTOINCREMENT ,
  name VARCHAR(45) NOT NULL ,
  UNIQUE  (name) );


-- -----------------------------------------------------
-- Table dep
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS dep (
  idDep INTEGER PRIMARY KEY AUTOINCREMENT ,
  idPackage INTEGER NOT NULL ,
  idPackageDep INTEGER NOT NULL ,
  idTypeOfDep INTEGER NOT NULL ,
  CONSTRAINT fk_pkg
    FOREIGN KEY (idPackage , idPackageDep )
    REFERENCES package (idPackage , idPackage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_type
    FOREIGN KEY (idTypeOfDep )
    REFERENCES typeDep (idTypeDep )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table packageXpackager
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS packageXpackager (
  idPackage INTEGER NOT NULL ,
  idPackager INTEGER NOT NULL ,
  CONSTRAINT fk_packageXpackager_package1
    FOREIGN KEY (idPackage )
    REFERENCES package (idPackage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_packageXpackager_packager2
    FOREIGN KEY (idPackager )
    REFERENCES packager (idPackager )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table packageXholdon
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS packageXholdon (
  idPackage INTEGER NOT NULL ,
  idHoldon INTEGER NOT NULL ,
  CONSTRAINT fk_packageXholdon_package1
    FOREIGN KEY (idPackage )
    REFERENCES package (idPackage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_packageXholdon_holdon1
    FOREIGN KEY (idHoldon )
    REFERENCES holdon (idHoldon )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table sectionXpackage
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS sectionXpackage (
  idSection INTEGER NOT NULL ,
  idPackage INTEGER NOT NULL ,
  CONSTRAINT fk_sectionXpackage_section1
    FOREIGN KEY (idSection )
    REFERENCES section (idSection )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_sectionXpackage_package1
    FOREIGN KEY (idPackage )
    REFERENCES package (idPackage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table content
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS content (
  idContent INTEGER PRIMARY KEY AUTOINCREMENT ,
  content BLOB NOT NULL ,
  idPackage INTEGER NOT NULL ,
  CONSTRAINT fk_content_package1
    FOREIGN KEY (idPackage )
    REFERENCES package (idPackage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table language
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS language (
  idLanguage INTEGER PRIMARY KEY AUTOINCREMENT ,
  srtName VARCHAR(45) NOT NULL ,
  name VARCHAR(45) NOT NULL);


-- -----------------------------------------------------
-- Table summary
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS summary (
  idSummary INTEGER PRIMARY KEY AUTOINCREMENT ,
  summary VARCHAR(45) NOT NULL ,
  idLanguage INTEGER NOT NULL ,
  idPackage INTEGER NOT NULL ,
  CONSTRAINT fk_summary_language1
    FOREIGN KEY (idLanguage )
    REFERENCES language (idLanguage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_summary_package1
    FOREIGN KEY (idPackage )
    REFERENCES package (idPackage )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
