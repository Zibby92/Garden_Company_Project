<h2 style="text-align: center;"><strong>Garden Company Project - Program to manage company that is creating gardens</strong></h2>
<h3>Description&nbsp;</h3>
<div>I'm making this project ragarding my own experience, when I was leading a company like this I needed pile of folders to efficient manage people, finances and getting conclusion after every another job. It is the reason why i made this, it substitute all paper work to comfort program containing all needed subprograms.&nbsp;</div>
<div>&nbsp;</div>
<div>My main goals during making it are:</div>
<ul>
<li>- Using my own experience at running a bussiness to create database with subprograms that will be huge help with it</li>
<li>- Improve my programming skills and strenghten knowleadge which I've got from many on-line courses</li>
<li>- Encounter with problems at work with bigger project and find best solutions to solve they</li>
<li>-Using most of PL/SQL and SQL features like VIEWS, TRIGGERS, PROCEDURES, SCHEDULES etc.&nbsp; to better understand and remember construction of they.</li>
</ul>
<div>&nbsp;</div>
<div>I used mostly PL/SQL and SQL, all I've wroten in SQLDEVELOPER, table structures and all ideas are mine.&nbsp;</div>
<h4>How to install all components:</h4>
<ul>
<li>Use SQLDeveloper, or if you don't have it take a look here:</li>
</ul>
<blockquote>
<div><a href="https://docs.oracle.com/en/database/oracle/sql-developer/19.1/rptig/installing-sql-developer.html#GUID-24E6A45E-DCCC-4210-B8C3-5F6AB33990FE">https://docs.oracle.com/en/database/oracle/sql-developer/19.1/rptig/installing-sql-developer.html#GUID-24E6A45E-DCCC-4210-B8C3-5F6AB33990FE</a></div>
</blockquote>
<ul>
<li>Create a new connection, if you don't know how it would help:</li>
</ul>
<blockquote>
<div>https://docs.oracle.com/en/database/oracle/oracle-database/tutorial-create-conn/index.html?opt-release-19c</div>
</blockquote>
<ul>
<li>You can name it as you like, when your connection is works and you can assure when write some basic query, for instance:&nbsp;</li>
</ul>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;SELECT sysdate FROM DUAL;</p>
<div>&nbsp;</div>
<ul>
<li>If current time shows up then you can download file "Full_install_script" from folder "INSTALL_SCRIPT" from my respository and open it in SQLDeveloper:</li>
</ul>
<p><img src="https://github.com/Zibby92/Garden_Company_Project/blob/main/INSTALL%20SCRIPT/1.jpg" alt="Where open sql file" width="742" height="580" /></p>
<p>Or just copy all text from:&nbsp;</p>
<blockquote>
<div>https://github.com/Zibby92/Garden_Company_Project/blob/main/INSTALL%20SCRIPT/Full_install_script.sql</div>
</blockquote>
<div>&nbsp;</div>
<div>and paste it in SQLDEVELOPER.</div>
<div>&nbsp;</div>
<ul>
<li>Next just click on icon with the small green arrow :</li>
</ul>
<p><img src="https://github.com/Zibby92/Garden_Company_Project/blob/main/INSTALL%20SCRIPT/2.jpg" alt="Where script starts" width="742" height="560" /></p>
<div>And it's ready to use. All tables, data and programs will be working.</div>
<div>Working functionalities:</div>
<div>&nbsp;</div>
<ol>
<li>pkg_additional_works_managment.add_work() - adding new job in two options using program overloading. In first options one's need Principal data to insert, in second only id_job if we know it yet.</li>
<li>pkg_employees_managment.add_employee() - hiring new empolee.</li>
<li>pkg_employees_managment.fire_worker() - dismiss employee.</li>
<li>pkg_jobs_managment.p_add_job() - adding new job</li>
<li>pkg_jobs_managment.p_begin_job() -&nbsp; set job as started and adding date of started</li>
<li>pkg_jobs_managment.p_end_job() - adding day of the end of particular job</li>
<li>pkg_jobs_managment.p_set_job_as_done() - setting job as done, automatically generate invoice with own unrepeatable code, adding statistics of job with extra data like all costs, amount of droven kilometers etc.</li>
<li>pkg_principal_managment.add_principal() - adding new principal</li>
<li>pkg_principal_managment.drop_principal - erase principal from memory</li>
<li>pkg_worked_hours.all_at_one_job() - set all employees to particular job during a day, most of days everybody are in the same place, it is for easy instert of data&nbsp; &nbsp;</li>
</ol>
<div>&nbsp;</div>
<div>Programs automaticly save errors to table when happend, when you insert wrong name or last name you will see person with similar data to check out corrent information. In the background are working trigger.</div>
<div>I'm trying to use different PL/SQL features as own record types, handling exceptions,&nbsp; excute immediately etc. Not every solutions are efficient but they help me to better understand language and improve skills in every field.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
