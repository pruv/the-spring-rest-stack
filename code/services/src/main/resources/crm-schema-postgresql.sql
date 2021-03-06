CREATE SEQUENCE hibernate_sequence;


--  schema for the CRM on the service side
--
CREATE TABLE user_account
(
  id                       BIGINT  NOT NULL,
  first_name               CHARACTER VARYING(255),
  last_name                CHARACTER VARYING(255),
  pass_word                CHARACTER VARYING(255),
  signup_date              TIMESTAMP WITHOUT TIME ZONE,
  user_name                CHARACTER VARYING(255),
  enabled                  BOOLEAN NOT NULL DEFAULT FALSE,
  profile_photo_imported   BOOLEAN NOT NULL DEFAULT FALSE,
  profile_photo_media_type CHARACTER VARYING(255),
  CONSTRAINT user_account_pkey PRIMARY KEY (id)
);

-- update the customers
--
CREATE TABLE customer
(
  id                    BIGINT NOT NULL,
  first_name            CHARACTER VARYING(255),
  last_name             CHARACTER VARYING(255),
  signup_date           TIMESTAMP WITHOUT TIME ZONE,
  customer_user_id_fkey BIGINT NOT NULL,
  CONSTRAINT customer_pkey PRIMARY KEY (id),
  CONSTRAINT fk24217fdef32da70a FOREIGN KEY (customer_user_id_fkey) REFERENCES user_account (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO public.user_account (id, first_name, last_name, pass_word, signup_date, user_name, enabled, profile_photo_imported, profile_photo_media_type) VALUES (nextval( 'hibernate_sequence'), 'Clark', 'Kent', 'uberman', '2013-06-02 15:33:51', 'clarkkent', TRUE, FALSE, null);
INSERT INTO public.user_account (id, first_name, last_name, pass_word, signup_date, user_name, enabled, profile_photo_imported, profile_photo_media_type) VALUES (nextval( 'hibernate_sequence'), 'Lois', 'Lane', 'thebetterhalf', '2013-06-02 15:33:51', 'loislane', TRUE, FALSE, null);
INSERT INTO public.user_account (id, first_name, last_name, pass_word, signup_date, user_name, enabled, profile_photo_imported, profile_photo_media_type) VALUES (nextval( 'hibernate_sequence'), 'Bruce', 'Wayne', 'alfred', '2013-06-02 15:33:51', 'brucewayne', TRUE, FALSE, null);
INSERT INTO public.user_account (id, first_name, last_name, pass_word, signup_date, user_name, enabled, profile_photo_imported, profile_photo_media_type) VALUES (nextval( 'hibernate_sequence'), 'Tony', 'Stark', 'pepper', '2013-06-02 15:33:51', 'tonystark', TRUE, FALSE, null);
INSERT INTO public.user_account (id, first_name, last_name, pass_word, signup_date, user_name, enabled, profile_photo_imported, profile_photo_media_type) VALUES (nextval( 'hibernate_sequence'), 'Josh', 'Long', 'cowbell', '2013-06-02 15:33:51', 'joshlong', TRUE, TRUE, null);
INSERT INTO public.user_account (id, first_name, last_name, pass_word, signup_date, user_name, enabled, profile_photo_imported, profile_photo_media_type) VALUES (nextval( 'hibernate_sequence'), 'George', 'Jetson', 'sprockets', '2013-07-18 20:52:28', 'georgelee', TRUE, FALSE, null);

INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'arjen', 'poutsma', '2013-06-12 22:37:22', 3);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'mark', 'pollack', '2013-06-12 22:37:22', 4);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'david', 'syer', '2013-06-12 22:37:22', 2);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'gunnar', 'hillert', '2013-06-12 22:37:22', 2);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'rossen', 'stoyanchev', '2013-06-12 22:37:22', 2);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'josh', 'long', '2013-06-13 14:13:05', 2);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'brian', 'dussault', '2013-06-13 17:07:21', 3);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'phill', 'webb', '2013-06-26 03:54:53', 4);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'scott', 'andrews', '2013-06-28 19:11:19', 2);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'mark', 'fisher', '2013-06-28 19:54:14', 5);
INSERT INTO public.customer (id, first_name, last_name, signup_date, customer_user_id_fkey) VALUES (nextval( 'hibernate_sequence'), 'josh', 'long', '2013-07-15 17:12:46', 6);

DROP TABLE IF EXISTS oauth_access_token;

CREATE TABLE public.oauth_access_token (
  token_id          TEXT PRIMARY KEY NOT NULL,
  token             BYTEA,
  authentication_id TEXT,
  user_name         TEXT,
  client_id         TEXT,
  authentication    TEXT,
  refresh_token     TEXT
);

