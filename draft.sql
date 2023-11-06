BEGIN
DBMS_OUTPUT.PUT_LINE(jobs_managment_pkg.find_by_name_and_last_name('ZBYSZEK','JAKIS'));
END;
/
EXECUTE principal_managment.add_principal('piotrek', 'jakis', 'POGORZEL' , 'MINSKA',12,12312313);
EXECUTE principal_managment.DROP_principal('ZBYSZEK', 'JAKIS');
SELECT * FROM PRINCIPALS;
/
execute jobs_managment_pkg.find_similar_principal('pioteds', 'jakis');