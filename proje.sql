PGDMP                         |            proje    13.14    13.14 (    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    proje    DATABASE     c   CREATE DATABASE proje WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_T�rkiye.1254';
    DROP DATABASE proje;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16412 	   doktorlar    TABLE     �   CREATE TABLE public.doktorlar (
    doktorid integer NOT NULL,
    kullaniciadi character varying(20),
    sifre character varying(20),
    ad character varying(30),
    soyad character varying(30),
    uzmanlikalan character varying(20)
);
    DROP TABLE public.doktorlar;
       public         heap    postgres    false    3            �            1259    16410    doktorlar_doktorid_seq    SEQUENCE     �   ALTER TABLE public.doktorlar ALTER COLUMN doktorid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doktorlar_doktorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    3    201            �            1259    16548    goruntuanalizi    TABLE     �   CREATE TABLE public.goruntuanalizi (
    analizid integer NOT NULL,
    hastaid integer,
    sinif character varying(25),
    dogrulukorani numeric
);
 "   DROP TABLE public.goruntuanalizi;
       public         heap    postgres    false    3            �            1259    16546    goruntuanalizi_analizid_seq    SEQUENCE     �   ALTER TABLE public.goruntuanalizi ALTER COLUMN analizid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.goruntuanalizi_analizid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    3    205            �            1259    16626    hastaanaliziliskisi    TABLE     �   CREATE TABLE public.hastaanaliziliskisi (
    analizid integer NOT NULL,
    hastaid integer,
    doktorid integer,
    sonuctarihi date,
    sonuc text,
    makaleid integer
);
 '   DROP TABLE public.hastaanaliziliskisi;
       public         heap    postgres    false    3            �            1259    16524    hastalar    TABLE     .  CREATE TABLE public.hastalar (
    hastaid integer NOT NULL,
    doktorid integer,
    hastatc character varying(11),
    ad character varying(20),
    soyad character varying(20),
    dogumtarihi date,
    cinsiyet character varying(30),
    kangrubu character varying(6),
    analizdurumu boolean
);
    DROP TABLE public.hastalar;
       public         heap    postgres    false    3            �            1259    16522    hastalar_hastaid_seq    SEQUENCE     �   ALTER TABLE public.hastalar ALTER COLUMN hastaid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hastalar_hastaid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    3    203            �            1259    16570    istatikselveriler    TABLE     J  CREATE TABLE public.istatikselveriler (
    kantestiid integer NOT NULL,
    hastaid integer,
    analiztarihi date,
    ca199 numeric,
    ca125 numeric,
    hgf numeric,
    opn numeric,
    omegascore numeric,
    prolactin numeric,
    cea numeric,
    myeloperoxidase numeric,
    timp1 numeric,
    dogrulukorani numeric
);
 %   DROP TABLE public.istatikselveriler;
       public         heap    postgres    false    3            �            1259    16568     istatikselveriler_kantestiid_seq    SEQUENCE     �   ALTER TABLE public.istatikselveriler ALTER COLUMN kantestiid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.istatikselveriler_kantestiid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207    3            �            1259    16618    makale    TABLE     �   CREATE TABLE public.makale (
    makaleid integer NOT NULL,
    pubmed_id integer,
    title text,
    ozet text,
    publication_date date,
    keywords text
);
    DROP TABLE public.makale;
       public         heap    postgres    false    3            �            1259    16616    makale_makaleid_seq    SEQUENCE     �   ALTER TABLE public.makale ALTER COLUMN makaleid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.makale_makaleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209    3            �          0    16412 	   doktorlar 
   TABLE DATA           [   COPY public.doktorlar (doktorid, kullaniciadi, sifre, ad, soyad, uzmanlikalan) FROM stdin;
    public          postgres    false    201   �1       �          0    16548    goruntuanalizi 
   TABLE DATA           Q   COPY public.goruntuanalizi (analizid, hastaid, sinif, dogrulukorani) FROM stdin;
    public          postgres    false    205   v2       �          0    16626    hastaanaliziliskisi 
   TABLE DATA           h   COPY public.hastaanaliziliskisi (analizid, hastaid, doktorid, sonuctarihi, sonuc, makaleid) FROM stdin;
    public          postgres    false    210   �2       �          0    16524    hastalar 
   TABLE DATA           x   COPY public.hastalar (hastaid, doktorid, hastatc, ad, soyad, dogumtarihi, cinsiyet, kangrubu, analizdurumu) FROM stdin;
    public          postgres    false    203   �2       �          0    16570    istatikselveriler 
   TABLE DATA           �   COPY public.istatikselveriler (kantestiid, hastaid, analiztarihi, ca199, ca125, hgf, opn, omegascore, prolactin, cea, myeloperoxidase, timp1, dogrulukorani) FROM stdin;
    public          postgres    false    207   �3       �          0    16618    makale 
   TABLE DATA           ^   COPY public.makale (makaleid, pubmed_id, title, ozet, publication_date, keywords) FROM stdin;
    public          postgres    false    209   �3       �           0    0    doktorlar_doktorid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.doktorlar_doktorid_seq', 3, true);
          public          postgres    false    200            �           0    0    goruntuanalizi_analizid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.goruntuanalizi_analizid_seq', 1, false);
          public          postgres    false    204            �           0    0    hastalar_hastaid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.hastalar_hastaid_seq', 18, true);
          public          postgres    false    202            �           0    0     istatikselveriler_kantestiid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.istatikselveriler_kantestiid_seq', 1, false);
          public          postgres    false    206            �           0    0    makale_makaleid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.makale_makaleid_seq', 1, false);
          public          postgres    false    208            C           2606    16416    doktorlar doktorlar_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.doktorlar
    ADD CONSTRAINT doktorlar_pkey PRIMARY KEY (doktorid);
 B   ALTER TABLE ONLY public.doktorlar DROP CONSTRAINT doktorlar_pkey;
       public            postgres    false    201            G           2606    16552 "   goruntuanalizi goruntuanalizi_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.goruntuanalizi
    ADD CONSTRAINT goruntuanalizi_pkey PRIMARY KEY (analizid);
 L   ALTER TABLE ONLY public.goruntuanalizi DROP CONSTRAINT goruntuanalizi_pkey;
       public            postgres    false    205            M           2606    16633 ,   hastaanaliziliskisi hastaanaliziliskisi_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.hastaanaliziliskisi
    ADD CONSTRAINT hastaanaliziliskisi_pkey PRIMARY KEY (analizid);
 V   ALTER TABLE ONLY public.hastaanaliziliskisi DROP CONSTRAINT hastaanaliziliskisi_pkey;
       public            postgres    false    210            E           2606    16528    hastalar hastalar_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.hastalar
    ADD CONSTRAINT hastalar_pkey PRIMARY KEY (hastaid);
 @   ALTER TABLE ONLY public.hastalar DROP CONSTRAINT hastalar_pkey;
       public            postgres    false    203            I           2606    16577 (   istatikselveriler istatikselveriler_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.istatikselveriler
    ADD CONSTRAINT istatikselveriler_pkey PRIMARY KEY (kantestiid);
 R   ALTER TABLE ONLY public.istatikselveriler DROP CONSTRAINT istatikselveriler_pkey;
       public            postgres    false    207            K           2606    16625    makale makale_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.makale
    ADD CONSTRAINT makale_pkey PRIMARY KEY (makaleid);
 <   ALTER TABLE ONLY public.makale DROP CONSTRAINT makale_pkey;
       public            postgres    false    209            O           2606    16553 *   goruntuanalizi goruntuanalizi_hastaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.goruntuanalizi
    ADD CONSTRAINT goruntuanalizi_hastaid_fkey FOREIGN KEY (hastaid) REFERENCES public.hastalar(hastaid);
 T   ALTER TABLE ONLY public.goruntuanalizi DROP CONSTRAINT goruntuanalizi_hastaid_fkey;
       public          postgres    false    205    2885    203            R           2606    16639 5   hastaanaliziliskisi hastaanaliziliskisi_doktorid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hastaanaliziliskisi
    ADD CONSTRAINT hastaanaliziliskisi_doktorid_fkey FOREIGN KEY (doktorid) REFERENCES public.doktorlar(doktorid);
 _   ALTER TABLE ONLY public.hastaanaliziliskisi DROP CONSTRAINT hastaanaliziliskisi_doktorid_fkey;
       public          postgres    false    210    201    2883            Q           2606    16634 4   hastaanaliziliskisi hastaanaliziliskisi_hastaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hastaanaliziliskisi
    ADD CONSTRAINT hastaanaliziliskisi_hastaid_fkey FOREIGN KEY (hastaid) REFERENCES public.hastalar(hastaid);
 ^   ALTER TABLE ONLY public.hastaanaliziliskisi DROP CONSTRAINT hastaanaliziliskisi_hastaid_fkey;
       public          postgres    false    2885    203    210            S           2606    16644 5   hastaanaliziliskisi hastaanaliziliskisi_makaleid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hastaanaliziliskisi
    ADD CONSTRAINT hastaanaliziliskisi_makaleid_fkey FOREIGN KEY (makaleid) REFERENCES public.makale(makaleid);
 _   ALTER TABLE ONLY public.hastaanaliziliskisi DROP CONSTRAINT hastaanaliziliskisi_makaleid_fkey;
       public          postgres    false    209    2891    210            N           2606    16529    hastalar hastalar_doktorid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hastalar
    ADD CONSTRAINT hastalar_doktorid_fkey FOREIGN KEY (doktorid) REFERENCES public.doktorlar(doktorid);
 I   ALTER TABLE ONLY public.hastalar DROP CONSTRAINT hastalar_doktorid_fkey;
       public          postgres    false    2883    201    203            P           2606    16578 0   istatikselveriler istatikselveriler_hastaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.istatikselveriler
    ADD CONSTRAINT istatikselveriler_hastaid_fkey FOREIGN KEY (hastaid) REFERENCES public.hastalar(hastaid);
 Z   ALTER TABLE ONLY public.istatikselveriler DROP CONSTRAINT istatikselveriler_hastaid_fkey;
       public          postgres    false    203    2885    207            �   h   x�3�LL<����Ș�1)�4''1C��2���<��s�r�R�y��9�Y�\Ɯ��)`��U�y
���%�.���E5��ũE�%�`u�`6g䑍9@��b���� u�*l      �      x������ � �      �      x������ � �      �   �   x�e�=N1����U��g<�%�T��4FL��Ud>$r�m� {0��~��G ���c��~�l��0�(��|t�����ؕóa{�0Hs԰J��Zzl�8O�w���LZNbR�̂{{�+�*س8�.���<�(u�;��)�n����\j��kl���3��H�؍��Ϗq�S�Ԃ^���]�}��K      �      x������ � �      �      x������ � �     