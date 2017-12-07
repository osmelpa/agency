
CREATE SEQUENCE public.model_id_model_seq;

CREATE TABLE public.model (
                id_model INTEGER NOT NULL DEFAULT nextval('public.model_id_model_seq'),
                model VARCHAR NOT NULL,
                CONSTRAINT model_pk PRIMARY KEY (id_model)
);


ALTER SEQUENCE public.model_id_model_seq OWNED BY public.model.id_model;

CREATE UNIQUE INDEX model_idx
 ON public.model
 ( model );

CREATE SEQUENCE public.brand_id_brand_seq;

CREATE TABLE public.brand (
                id_brand INTEGER NOT NULL DEFAULT nextval('public.brand_id_brand_seq'),
                brand VARCHAR NOT NULL,
                id_model INTEGER NOT NULL,
                CONSTRAINT brand_pk PRIMARY KEY (id_brand)
);


ALTER SEQUENCE public.brand_id_brand_seq OWNED BY public.brand.id_brand;

CREATE UNIQUE INDEX brand_idx
 ON public.brand
 ( brand );

CREATE SEQUENCE public.car_id_car_seq;

CREATE TABLE public.car (
                id_car INTEGER NOT NULL DEFAULT nextval('public.car_id_car_seq'),
                plates VARCHAR NOT NULL,
                id_brand INTEGER NOT NULL,
                color VARCHAR NOT NULL,
                price DOUBLE PRECISION NOT NULL,
                photo VARCHAR NOT NULL,
                sale BOOLEAN NOT NULL,
                service BOOLEAN NOT NULL,
                new_car BOOLEAN NOT NULL,
                CONSTRAINT car_pk PRIMARY KEY (id_car)
);


ALTER SEQUENCE public.car_id_car_seq OWNED BY public.car.id_car;

CREATE UNIQUE INDEX car_idx
 ON public.car
 ( plates );

CREATE SEQUENCE public.customer_id_customer_seq;

CREATE TABLE public.customer (
                id_customer INTEGER NOT NULL DEFAULT nextval('public.customer_id_customer_seq'),
                name VARCHAR NOT NULL,
                address VARCHAR NOT NULL,
                identification_no INTEGER NOT NULL,
                phone VARCHAR NOT NULL,
                CONSTRAINT customer_pk PRIMARY KEY (id_customer)
);


ALTER SEQUENCE public.customer_id_customer_seq OWNED BY public.customer.id_customer;

CREATE UNIQUE INDEX customer_idx
 ON public.customer
 ( identification_no );

CREATE SEQUENCE public.operation_id_operation_seq;

CREATE TABLE public.operation (
                id_operation INTEGER NOT NULL DEFAULT nextval('public.operation_id_operation_seq'),
                date DATE NOT NULL,
                id_customer INTEGER NOT NULL,
                id_car INTEGER NOT NULL,
                CONSTRAINT operation_pk PRIMARY KEY (id_operation)
);


ALTER SEQUENCE public.operation_id_operation_seq OWNED BY public.operation.id_operation;

CREATE TABLE public.maintenance_reparation (
                id_operation INTEGER NOT NULL,
                entry_date DATE NOT NULL,
                exit_date DATE NOT NULL,
                description VARCHAR NOT NULL,
                price_service DOUBLE PRECISION NOT NULL,
                maintenance BOOLEAN NOT NULL,
                reparation BOOLEAN NOT NULL,
                CONSTRAINT maintenance_reparation_pk PRIMARY KEY (id_operation)
);


CREATE TABLE public.change (
                id_operation INTEGER NOT NULL,
                id_car INTEGER NOT NULL,
                CONSTRAINT change_pk PRIMARY KEY (id_operation)
);


CREATE TABLE public.finance (
                id_operation INTEGER NOT NULL,
                customer_salary DOUBLE PRECISION NOT NULL,
                pay_quota DOUBLE PRECISION NOT NULL,
                amount_period INTEGER NOT NULL,
                start_date DATE NOT NULL,
                finish_date DATE NOT NULL,
                CONSTRAINT finance_pk PRIMARY KEY (id_operation)
);


CREATE TABLE public.buy (
                id_operation INTEGER NOT NULL,
                buy_price DOUBLE PRECISION NOT NULL,
                CONSTRAINT buy_pk PRIMARY KEY (id_operation)
);


CREATE TABLE public.sale (
                id_operation INTEGER NOT NULL,
                sale_price DOUBLE PRECISION NOT NULL,
                CONSTRAINT sale_pk PRIMARY KEY (id_operation)
);


ALTER TABLE public.brand ADD CONSTRAINT model_brand_fk
FOREIGN KEY (id_model)
REFERENCES public.model (id_model)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.car ADD CONSTRAINT brand_car_fk
FOREIGN KEY (id_brand)
REFERENCES public.brand (id_brand)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.operation ADD CONSTRAINT car_operation_fk
FOREIGN KEY (id_car)
REFERENCES public.car (id_car)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.change ADD CONSTRAINT car_change_fk
FOREIGN KEY (id_car)
REFERENCES public.car (id_car)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.operation ADD CONSTRAINT customer_operation_fk
FOREIGN KEY (id_customer)
REFERENCES public.customer (id_customer)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.sale ADD CONSTRAINT operation_sale_fk
FOREIGN KEY (id_operation)
REFERENCES public.operation (id_operation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.buy ADD CONSTRAINT operation_buy_fk
FOREIGN KEY (id_operation)
REFERENCES public.operation (id_operation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.finance ADD CONSTRAINT operation_finance_fk
FOREIGN KEY (id_operation)
REFERENCES public.operation (id_operation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.change ADD CONSTRAINT operation_change_fk
FOREIGN KEY (id_operation)
REFERENCES public.operation (id_operation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.maintenance_reparation ADD CONSTRAINT operation_service_fk
FOREIGN KEY (id_operation)
REFERENCES public.operation (id_operation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
