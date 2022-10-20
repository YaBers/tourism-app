CREATE TABLE IF NOT EXISTS language_code_name (

    language_code serial PRIMARY KEY,
    language_name VARCHAR ( 50 )

);
CREATE TABLE IF NOT EXISTS restaurants (

    restaurant_id serial PRIMARY KEY,
    restaurant_name VARCHAR ( 50 ) NOT NULL, -- unique?
    restaurant_location VARCHAR ( 50 ) NOT NULL, -- foriegn key to address database? should this be used to determine proximity --- unique??
    language_code INTEGER REFERENCES language_code_name ( language_code )

);
CREATE TABLE IF NOT EXISTS users (

    user_id serial PRIMARY KEY,
    user_name VARCHAR ( 50 ) NOT NULL UNIQUE,
    user_password VARCHAR ( 50 ) NOT NULL, -- store hash
    first_name VARCHAR ( 50 ) NOT NULL,
    last_name VARCHAR ( 255 ) NOT NULL,
    email VARCHAR ( 50 ) NOT NULL UNIQUE,
    salt VARCHAR ( 10 ) NOT NULL,
    home_country VARCHAR ( 50 ) DEFAULT NULL,
    user_location VARCHAR ( 50 ) DEFAULT NULL,
    profile_picture_path VARCHAR ( 255 ) DEFAULT NULL,
    language_code INTEGER REFERENCES language_code_name ( language_code ),
    created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP DEFAULT NULL,
    profile_public_flag VARCHAR ( 1 ) DEFAULT 'Y'

);

CREATE TABLE IF NOT EXISTS restaurant_reviews (

    review_id serial PRIMARY KEY,
    restaurant_id INTEGER REFERENCES restaurants ( restaurant_id ),
    user_id INTEGER REFERENCES users ( user_id ),
    rating NUMERIC(4, 2) DEFAULT NULL,
    review_header VARCHAR ( 100 ) NOT NULL,
    review_body VARCHAR ( 1000 ) NOT NULL,       --https://stackoverflow.com/questions/2892705/how-do-i-model-product-ratings-in-the-database
    created_on TIMESTAMP NOT NULL,
    likes INT DEFAULT 0

);
CREATE TABLE IF NOT EXISTS restaurant_reviews_images (

    image_id serial PRIMARY KEY,
    review_id INTEGER REFERENCES restaurant_reviews ( review_id ),
    image_path VARCHAR ( 255 ) NOT NULL

);
CREATE TABLE IF NOT EXISTS phrase_code_name (

    phrase_code serial PRIMARY KEY,
    eng_phrase VARCHAR ( 100 )

);
CREATE TABLE IF NOT EXISTS phrases (

    phrase_code INTEGER REFERENCES phrase_code_name ( phrase_code ),
    language_code INTEGER REFERENCES language_code_name ( language_code ),
    phrase_translated VARCHAR ( 100 )

);

-- drop schema public cascade;
-- CREATE SCHEMA public;
-- 
-- GRANT ALL ON SCHEMA public TO postgres;
-- GRANT ALL ON SCHEMA public TO public;