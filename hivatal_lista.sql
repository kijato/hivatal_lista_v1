-- Table: kodok.hivatal_lista

-- DROP TABLE kodok.hivatal_lista;

CREATE TABLE kodok.hivatal_lista
(
  sorszam serial NOT NULL,
  email character varying(51), -- Email
  interfesztipusa character varying(14), -- InterfeszTipusa
  krid integer NOT NULL, -- KRID
  letrehozasdatuma timestamp without time zone, -- LetrehozasDatuma
  makkod integer, -- MAKKod
  megye character varying(22), -- Megye
  nev character varying(174), -- Nev
  rovidnev character varying(10) NOT NULL, -- RovidNev
  statusz character varying(5), -- Statusz
  CONSTRAINT pk_hivatal_lista PRIMARY KEY (sorszam),
  CONSTRAINT u_krid UNIQUE (krid),
  CONSTRAINT u_rovidnev UNIQUE (rovidnev)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE kodok.hivatal_lista
  OWNER TO postgres;
COMMENT ON TABLE kodok.hivatal_lista
  IS 'A ''https://tarhely.gov.hu/hivatalkereso/hivatal_lista.pdf'' címen elérhető PDF-be ágyazott XML-ből CSV-n keresztül kinyert adatok.

Minta [XML]:
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Hivatalok>
    <Hivatal>
        <RovidNev>00001AN</RovidNev>
        <Nev>NEM CÍMEZHETŐ!!! NAV SPECIÁLIS HASZNÁLATÚ HK-ja! </Nev>
        <MAKKod>789938000</MAKKod>
        <KRID>653219198</KRID>
        <Email>it.helpdesk@nav.gov.hu</Email>
        <LetrehozasDatuma>2018-03-30T00:00:00+02:00</LetrehozasDatuma>
        <InterfeszTipusa>gépi és web-es</InterfeszTipusa>
        <Megye>Budapest</Megye>
        <Statusz>aktív</Statusz>
    </Hivatal>
...
</Hivatalok>

Minta [CSV]:
Email;InterfeszTipusa;KRID;LetrehozasDatuma;MAKKod;Megye;Nev;RovidNev;Statusz;
"it.helpdesk@nav.gov.hu";"gépi és web-es";"653219198";"2018-03-30T00:00:00+02:00";"789938000";"Budapest";"NEM CÍMEZHETŐ!!! NAV SPECIÁLIS HASZNÁLATÚ HK-ja! ";"00001AN";"aktív";
...
';

COMMENT ON COLUMN kodok.hivatal_lista.email IS 'Email';
COMMENT ON COLUMN kodok.hivatal_lista.interfesztipusa IS 'InterfeszTipusa';
COMMENT ON COLUMN kodok.hivatal_lista.krid IS 'KRID';
COMMENT ON COLUMN kodok.hivatal_lista.letrehozasdatuma IS 'LetrehozasDatuma';
COMMENT ON COLUMN kodok.hivatal_lista.makkod IS 'MAKKod';
COMMENT ON COLUMN kodok.hivatal_lista.megye IS 'Megye';
COMMENT ON COLUMN kodok.hivatal_lista.nev IS 'Nev';
COMMENT ON COLUMN kodok.hivatal_lista.rovidnev IS 'RovidNev';
COMMENT ON COLUMN kodok.hivatal_lista.statusz IS 'Statusz';


-- Index: kodok.i_krid

-- DROP INDEX kodok.i_krid;

CREATE INDEX i_krid
  ON kodok.hivatal_lista
  USING btree
  (krid);

-- Index: kodok.i_nev

-- DROP INDEX kodok.i_nev;

CREATE INDEX i_nev
  ON kodok.hivatal_lista
  USING btree
  (nev COLLATE pg_catalog."default");

-- Index: kodok.i_rovidnev

-- DROP INDEX kodok.i_rovidnev;

CREATE INDEX i_rovidnev
  ON kodok.hivatal_lista
  USING btree
  (rovidnev COLLATE pg_catalog."default");

