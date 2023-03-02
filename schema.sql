/* Database schema to keep the structure of entire database. */

CREATE TABLE IF NOT EXISTS animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg FLOAT NOT NULL
);

-- Add a new column species to the animals table
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- Create table owners
CREATE TABLE IF NOT EXISTS owners (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Create table species
CREATE TABLE IF NOT EXISTS species (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Modify animals table:
--    Make sure that id is set as autoincremented PRIMARY KEY
--    Remove column species
--    Add column species_id which is a foreign key referencing species table
--    Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD PRIMARY KEY (id);
ALTER TABLE animals 
    DROP COLUMN species, 
    ADD COLUMN species_id INT REFERENCES species(id),
    ADD COLUMN owner_id INT REFERENCES owners(id);

-- Create table vets
CREATE TABLE IF NOT EXISTS vets (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL
);

-- Intermediary table to hold m-n relationship between species and vets
CREATE TABLE IF NOT EXISTS specializations (
    species_id INT NOT NULL REFERENCES species(id),
    vet_id INT NOT NULL REFERENCES vets(id),
    PRIMARY KEY (species_id, vet_id)
);

-- Intermediary table to hold m-n relationship between animals and vets
CREATE TABLE visits (
	animals_id INT NOT NULL REFERENCES animals (id),
	vets_id INT NOT NULL REFERENCES vets (id),
	date_of_visit DATE NOT NULL
);
