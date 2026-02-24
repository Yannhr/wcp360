<p data-start="191" data-end="219">WCP360 Database Architecture</p>
<p data-start="221" data-end="291">This document defines the relational database architecture for WCP360.</p>
<p data-start="293" data-end="303">It covers:</p>

<ul data-start="305" data-end="443">
 	<li data-start="305" data-end="322">
<p data-start="307" data-end="322">Core entities</p>
</li>
 	<li data-start="323" data-end="339">
<p data-start="325" data-end="339">Tenant model</p>
</li>
 	<li data-start="340" data-end="371">
<p data-start="342" data-end="371">Hosting packages and limits</p>
</li>
 	<li data-start="372" data-end="390">
<p data-start="374" data-end="390">Usage tracking</p>
</li>
 	<li data-start="391" data-end="409">
<p data-start="393" data-end="409">RBAC structure</p>
</li>
 	<li data-start="410" data-end="443">
<p data-start="412" data-end="443">Relationships and constraints</p>
</li>
</ul>
<p data-start="445" data-end="541">The database must enforce strict multi-tenant isolation and support scalable hosting management.</p>

<ol data-start="544" data-end="859">
 	<li data-start="544" data-end="569">
<p data-start="547" data-end="569">Core Design Principles</p>
</li>
 	<li data-start="571" data-end="609">
<p data-start="574" data-end="609">Every resource belongs to a tenant.</p>
</li>
 	<li data-start="610" data-end="647">
<p data-start="613" data-end="647">Every tenant belongs to a package.</p>
</li>
 	<li data-start="648" data-end="689">
<p data-start="651" data-end="689">Every limit is derived from a package.</p>
</li>
 	<li data-start="690" data-end="724">
<p data-start="693" data-end="724">Every action is scoped by RBAC.</p>
</li>
 	<li data-start="725" data-end="772">
<p data-start="728" data-end="772">No resource exists without tenant ownership.</p>
</li>
 	<li data-start="773" data-end="825">
<p data-start="776" data-end="825">Admin and reseller hierarchies must be supported.</p>
</li>
 	<li data-start="828" data-end="859">
<p data-start="831" data-end="859">Entity Relationship Overview</p>
</li>
</ol>
<p data-start="861" data-end="880">Main relationships:</p>
<p data-start="882" data-end="941">USERS ↔ USER_ROLES ↔ ROLES ↔ ROLE_PERMISSIONS ↔ PERMISSIONS</p>
<p data-start="943" data-end="1074">TENANTS → PACKAGES → PACKAGE_LIMITS<br data-start="978" data-end="981" />TENANTS → DOMAINS<br data-start="998" data-end="1001" />TENANTS → DATABASES<br data-start="1020" data-end="1023" />TENANTS → EMAIL_ACCOUNTS<br data-start="1047" data-end="1050" />TENANTS → TENANT_USAGE</p>
<p data-start="1076" data-end="1113">TENANTS contain USERS (client users).</p>
<p data-start="1115" data-end="1158">Each resource is strictly tied to a tenant.</p>

<ol start="3" data-start="1161" data-end="1175">
 	<li data-start="1161" data-end="1175">
<p data-start="1164" data-end="1175">Core Tables</p>
</li>
</ol>
<p data-start="1177" data-end="1188">3.1 Tenants</p>
<p data-start="1190" data-end="1218">Represents hosting accounts.</p>
<p data-start="1220" data-end="1227">tenants</p>

<ul data-start="1228" data-end="1457">
 	<li data-start="1228" data-end="1252">
<p data-start="1230" data-end="1252">id (uuid, primary key)</p>
</li>
 	<li data-start="1253" data-end="1259">
<p data-start="1255" data-end="1259">name</p>
</li>
 	<li data-start="1260" data-end="1300">
<p data-start="1262" data-end="1300">owner_user_id (foreign key → users.id)</p>
</li>
 	<li data-start="1301" data-end="1341">
<p data-start="1303" data-end="1341">package_id (foreign key → packages.id)</p>
</li>
 	<li data-start="1342" data-end="1379">
<p data-start="1344" data-end="1379">status (active, suspended, deleted)</p>
</li>
 	<li data-start="1380" data-end="1431">
<p data-start="1382" data-end="1431">reseller_id (nullable foreign key → resellers.id)</p>
</li>
 	<li data-start="1432" data-end="1444">
<p data-start="1434" data-end="1444">created_at</p>
</li>
 	<li data-start="1445" data-end="1457">
<p data-start="1447" data-end="1457">updated_at</p>
</li>
</ul>
<p data-start="1459" data-end="1511">Each tenant represents one isolated hosting account.</p>
<p data-start="1514" data-end="1523">3.2 Users</p>
<p data-start="1525" data-end="1564">System users (admin, reseller, client).</p>
<p data-start="1566" data-end="1571">users</p>

<ul data-start="1572" data-end="1731">
 	<li data-start="1572" data-end="1596">
<p data-start="1574" data-end="1596">id (uuid, primary key)</p>
</li>
 	<li data-start="1597" data-end="1613">
<p data-start="1599" data-end="1613">email (unique)</p>
</li>
 	<li data-start="1614" data-end="1629">
<p data-start="1616" data-end="1629">password_hash</p>
</li>
 	<li data-start="1630" data-end="1657">
<p data-start="1632" data-end="1657">is_system_admin (boolean)</p>
</li>
 	<li data-start="1658" data-end="1705">
<p data-start="1660" data-end="1705">tenant_id (nullable foreign key → tenants.id)</p>
</li>
 	<li data-start="1706" data-end="1718">
<p data-start="1708" data-end="1718">created_at</p>
</li>
 	<li data-start="1719" data-end="1731">
<p data-start="1721" data-end="1731">updated_at</p>
</li>
</ul>
<p data-start="1733" data-end="1739">Rules:</p>

<ul data-start="1741" data-end="1882">
 	<li data-start="1741" data-end="1776">
<p data-start="1743" data-end="1776">System admin → tenant_id is null.</p>
</li>
 	<li data-start="1777" data-end="1815">
<p data-start="1779" data-end="1815">Tenant user → tenant_id is not null.</p>
</li>
 	<li data-start="1816" data-end="1882">
<p data-start="1818" data-end="1882">Reseller user → tenant_id is null but linked in resellers table.</p>
</li>
</ul>
<ol start="4" data-start="1885" data-end="1909">
 	<li data-start="1885" data-end="1909">
<p data-start="1888" data-end="1909">Hosting Package Model</p>
</li>
</ol>
<p data-start="1911" data-end="1923">4.1 Packages</p>
<p data-start="1925" data-end="1947">Defines hosting plans.</p>
<p data-start="1949" data-end="1957">packages</p>

<ul data-start="1958" data-end="2089">
 	<li data-start="1958" data-end="1982">
<p data-start="1960" data-end="1982">id (uuid, primary key)</p>
</li>
 	<li data-start="1983" data-end="1989">
<p data-start="1985" data-end="1989">name</p>
</li>
 	<li data-start="1990" data-end="2003">
<p data-start="1992" data-end="2003">description</p>
</li>
 	<li data-start="2004" data-end="2041">
<p data-start="2006" data-end="2041">created_by (foreign key → users.id)</p>
</li>
 	<li data-start="2042" data-end="2063">
<p data-start="2044" data-end="2063">is_system (boolean)</p>
</li>
 	<li data-start="2064" data-end="2076">
<p data-start="2066" data-end="2076">created_at</p>
</li>
 	<li data-start="2077" data-end="2089">
<p data-start="2079" data-end="2089">updated_at</p>
</li>
</ul>
<p data-start="2092" data-end="2110">4.2 Package Limits</p>
<p data-start="2112" data-end="2148">Defines resource and feature limits.</p>
<p data-start="2150" data-end="2164">package_limits</p>

<ul data-start="2165" data-end="2528">
 	<li data-start="2165" data-end="2189">
<p data-start="2167" data-end="2189">id (uuid, primary key)</p>
</li>
 	<li data-start="2190" data-end="2230">
<p data-start="2192" data-end="2230">package_id (foreign key → packages.id)</p>
</li>
 	<li data-start="2231" data-end="2244">
<p data-start="2233" data-end="2244">max_domains</p>
</li>
 	<li data-start="2245" data-end="2261">
<p data-start="2247" data-end="2261">max_subdomains</p>
</li>
 	<li data-start="2262" data-end="2277">
<p data-start="2264" data-end="2277">max_databases</p>
</li>
 	<li data-start="2278" data-end="2292">
<p data-start="2280" data-end="2292">max_db_users</p>
</li>
 	<li data-start="2293" data-end="2313">
<p data-start="2295" data-end="2313">max_email_accounts</p>
</li>
 	<li data-start="2314" data-end="2327">
<p data-start="2316" data-end="2327">max_disk_mb</p>
</li>
 	<li data-start="2328" data-end="2346">
<p data-start="2330" data-end="2346">max_bandwidth_mb</p>
</li>
 	<li data-start="2347" data-end="2364">
<p data-start="2349" data-end="2364">max_cpu_percent</p>
</li>
 	<li data-start="2365" data-end="2380">
<p data-start="2367" data-end="2380">max_memory_mb</p>
</li>
 	<li data-start="2381" data-end="2402">
<p data-start="2383" data-end="2402">allow_ssh (boolean)</p>
</li>
 	<li data-start="2403" data-end="2425">
<p data-start="2405" data-end="2425">allow_cron (boolean)</p>
</li>
 	<li data-start="2426" data-end="2447">
<p data-start="2428" data-end="2447">allow_git (boolean)</p>
</li>
 	<li data-start="2448" data-end="2473">
<p data-start="2450" data-end="2473">allow_staging (boolean)</p>
</li>
 	<li data-start="2474" data-end="2502">
<p data-start="2476" data-end="2502">allow_api_access (boolean)</p>
</li>
 	<li data-start="2503" data-end="2515">
<p data-start="2505" data-end="2515">created_at</p>
</li>
 	<li data-start="2516" data-end="2528">
<p data-start="2518" data-end="2528">updated_at</p>
</li>
</ul>
<p data-start="2530" data-end="2579">Each package must have exactly one limits record.</p>

<ol start="5" data-start="2582" data-end="2606">
 	<li data-start="2582" data-end="2606">
<p data-start="2585" data-end="2606">Tenant Usage Tracking</p>
</li>
</ol>
<p data-start="2608" data-end="2653">Tracks real-time consumption and enforcement.</p>
<p data-start="2655" data-end="2667">tenant_usage</p>

<ul data-start="2668" data-end="2871">
 	<li data-start="2668" data-end="2692">
<p data-start="2670" data-end="2692">id (uuid, primary key)</p>
</li>
 	<li data-start="2693" data-end="2731">
<p data-start="2695" data-end="2731">tenant_id (foreign key → tenants.id)</p>
</li>
 	<li data-start="2732" data-end="2746">
<p data-start="2734" data-end="2746">used_domains</p>
</li>
 	<li data-start="2747" data-end="2763">
<p data-start="2749" data-end="2763">used_databases</p>
</li>
 	<li data-start="2764" data-end="2785">
<p data-start="2766" data-end="2785">used_email_accounts</p>
</li>
 	<li data-start="2786" data-end="2800">
<p data-start="2788" data-end="2800">used_disk_mb</p>
</li>
 	<li data-start="2801" data-end="2820">
<p data-start="2803" data-end="2820">used_bandwidth_mb</p>
</li>
 	<li data-start="2821" data-end="2840">
<p data-start="2823" data-end="2840">cpu_usage_percent</p>
</li>
 	<li data-start="2841" data-end="2858">
<p data-start="2843" data-end="2858">memory_usage_mb</p>
</li>
 	<li data-start="2859" data-end="2871">
<p data-start="2861" data-end="2871">updated_at</p>
</li>
</ul>
<p data-start="2873" data-end="2957">Core logic validates usage against package_limits before provisioning new resources.</p>

<ol start="6" data-start="2960" data-end="2980">
 	<li data-start="2960" data-end="2980">
<p data-start="2963" data-end="2980">Hosting Resources</p>
</li>
</ol>
<p data-start="2982" data-end="2993">6.1 Domains</p>
<p data-start="2995" data-end="3002">domains</p>

<ul data-start="3003" data-end="3124">
 	<li data-start="3003" data-end="3027">
<p data-start="3005" data-end="3027">id (uuid, primary key)</p>
</li>
 	<li data-start="3028" data-end="3066">
<p data-start="3030" data-end="3066">tenant_id (foreign key → tenants.id)</p>
</li>
 	<li data-start="3067" data-end="3089">
<p data-start="3069" data-end="3089">domain_name (unique)</p>
</li>
 	<li data-start="3090" data-end="3098">
<p data-start="3092" data-end="3098">status</p>
</li>
 	<li data-start="3099" data-end="3111">
<p data-start="3101" data-end="3111">created_at</p>
</li>
 	<li data-start="3112" data-end="3124">
<p data-start="3114" data-end="3124">updated_at</p>
</li>
</ul>
<p data-start="3126" data-end="3139">6.2 Databases</p>
<p data-start="3141" data-end="3150">databases</p>

<ul data-start="3151" data-end="3263">
 	<li data-start="3151" data-end="3175">
<p data-start="3153" data-end="3175">id (uuid, primary key)</p>
</li>
 	<li data-start="3176" data-end="3214">
<p data-start="3178" data-end="3214">tenant_id (foreign key → tenants.id)</p>
</li>
 	<li data-start="3215" data-end="3221">
<p data-start="3217" data-end="3221">name</p>
</li>
 	<li data-start="3222" data-end="3250">
<p data-start="3224" data-end="3250">engine (mariadb, postgres)</p>
</li>
 	<li data-start="3251" data-end="3263">
<p data-start="3253" data-end="3263">created_at</p>
</li>
</ul>
<p data-start="3265" data-end="3283">6.3 Email Accounts</p>
<p data-start="3285" data-end="3299">email_accounts</p>

<ul data-start="3300" data-end="3419">
 	<li data-start="3300" data-end="3324">
<p data-start="3302" data-end="3324">id (uuid, primary key)</p>
</li>
 	<li data-start="3325" data-end="3363">
<p data-start="3327" data-end="3363">tenant_id (foreign key → tenants.id)</p>
</li>
 	<li data-start="3364" data-end="3379">
<p data-start="3366" data-end="3379">email_address</p>
</li>
 	<li data-start="3380" data-end="3395">
<p data-start="3382" data-end="3395">password_hash</p>
</li>
 	<li data-start="3396" data-end="3406">
<p data-start="3398" data-end="3406">quota_mb</p>
</li>
 	<li data-start="3407" data-end="3419">
<p data-start="3409" data-end="3419">created_at</p>
</li>
</ul>
<ol start="7" data-start="3422" data-end="3442">
 	<li data-start="3422" data-end="3442">
<p data-start="3425" data-end="3442">RBAC Architecture</p>
</li>
</ol>
<p data-start="3444" data-end="3487">RBAC must be fully relational and flexible.</p>
<p data-start="3489" data-end="3498">7.1 Roles</p>
<p data-start="3500" data-end="3505">roles</p>

<ul data-start="3506" data-end="3594">
 	<li data-start="3506" data-end="3530">
<p data-start="3508" data-end="3530">id (uuid, primary key)</p>
</li>
 	<li data-start="3531" data-end="3546">
<p data-start="3533" data-end="3546">name (unique)</p>
</li>
 	<li data-start="3547" data-end="3581">
<p data-start="3549" data-end="3581">scope (system, reseller, tenant)</p>
</li>
 	<li data-start="3582" data-end="3594">
<p data-start="3584" data-end="3594">created_at</p>
</li>
</ul>
<p data-start="3596" data-end="3605">Examples:</p>

<ul data-start="3606" data-end="3651">
 	<li data-start="3606" data-end="3620">
<p data-start="3608" data-end="3620">system_admin</p>
</li>
 	<li data-start="3621" data-end="3637">
<p data-start="3623" data-end="3637">reseller_admin</p>
</li>
 	<li data-start="3638" data-end="3651">
<p data-start="3640" data-end="3651">tenant_user</p>
</li>
</ul>
<p data-start="3653" data-end="3668">7.2 Permissions</p>
<p data-start="3670" data-end="3681">permissions</p>

<ul data-start="3682" data-end="3736">
 	<li data-start="3682" data-end="3706">
<p data-start="3684" data-end="3706">id (uuid, primary key)</p>
</li>
 	<li data-start="3707" data-end="3722">
<p data-start="3709" data-end="3722">name (unique)</p>
</li>
 	<li data-start="3723" data-end="3736">
<p data-start="3725" data-end="3736">description</p>
</li>
</ul>
<p data-start="3738" data-end="3747">Examples:</p>

<ul data-start="3748" data-end="3849">
 	<li data-start="3748" data-end="3763">
<p data-start="3750" data-end="3763">tenant.create</p>
</li>
 	<li data-start="3764" data-end="3779">
<p data-start="3766" data-end="3779">tenant.delete</p>
</li>
 	<li data-start="3780" data-end="3795">
<p data-start="3782" data-end="3795">domain.create</p>
</li>
 	<li data-start="3796" data-end="3813">
<p data-start="3798" data-end="3813">database.create</p>
</li>
 	<li data-start="3814" data-end="3830">
<p data-start="3816" data-end="3830">package.create</p>
</li>
 	<li data-start="3831" data-end="3849">
<p data-start="3833" data-end="3849">system.configure</p>
</li>
</ul>
<p data-start="3851" data-end="3871">7.3 Role Permissions</p>
<p data-start="3873" data-end="3889">role_permissions</p>

<ul data-start="3890" data-end="4009">
 	<li data-start="3890" data-end="3924">
<p data-start="3892" data-end="3924">role_id (foreign key → roles.id)</p>
</li>
 	<li data-start="3925" data-end="4009">
<p data-start="3927" data-end="4009">permission_id (foreign key → permissions.id)
Primary key: (role_id, permission_id)</p>
</li>
</ul>
<p data-start="4011" data-end="4025">7.4 User Roles</p>
<p data-start="4027" data-end="4037">user_roles</p>

<ul data-start="4038" data-end="4139">
 	<li data-start="4038" data-end="4072">
<p data-start="4040" data-end="4072">user_id (foreign key → users.id)</p>
</li>
 	<li data-start="4073" data-end="4139">
<p data-start="4075" data-end="4139">role_id (foreign key → roles.id)
Primary key: (user_id, role_id)</p>
</li>
</ul>
<ol start="8" data-start="4142" data-end="4167">
 	<li data-start="4142" data-end="4167">
<p data-start="4145" data-end="4167">RBAC Enforcement Model</p>
</li>
</ol>
<p data-start="4169" data-end="4188">Authorization flow:</p>

<ol data-start="4190" data-end="4339">
 	<li data-start="4190" data-end="4211">
<p data-start="4193" data-end="4211">Authenticate user.</p>
</li>
 	<li data-start="4212" data-end="4235">
<p data-start="4215" data-end="4235">Load assigned roles.</p>
</li>
 	<li data-start="4236" data-end="4261">
<p data-start="4239" data-end="4261">Aggregate permissions.</p>
</li>
 	<li data-start="4262" data-end="4291">
<p data-start="4265" data-end="4291">Validate requested action.</p>
</li>
 	<li data-start="4292" data-end="4317">
<p data-start="4295" data-end="4317">Validate tenant scope.</p>
</li>
 	<li data-start="4318" data-end="4339">
<p data-start="4321" data-end="4339">Execute operation.</p>
</li>
</ol>
<p data-start="4341" data-end="4347">Rules:</p>

<ul data-start="4349" data-end="4483">
 	<li data-start="4349" data-end="4399">
<p data-start="4351" data-end="4399">System admin bypasses tenant scope restrictions.</p>
</li>
 	<li data-start="4400" data-end="4436">
<p data-start="4402" data-end="4436">Reseller limited to owned tenants.</p>
</li>
 	<li data-start="4437" data-end="4483">
<p data-start="4439" data-end="4483">Tenant users limited to their own tenant_id.</p>
</li>
</ul>
<ol start="9" data-start="4486" data-end="4514">
 	<li data-start="4486" data-end="4514">
<p data-start="4489" data-end="4514">Reseller Model (Optional)</p>
</li>
</ol>
<p data-start="4516" data-end="4525">resellers</p>

<ul data-start="4526" data-end="4657">
 	<li data-start="4526" data-end="4550">
<p data-start="4528" data-end="4550">id (uuid, primary key)</p>
</li>
 	<li data-start="4551" data-end="4585">
<p data-start="4553" data-end="4585">user_id (foreign key → users.id)</p>
</li>
 	<li data-start="4586" data-end="4599">
<p data-start="4588" data-end="4599">max_tenants</p>
</li>
 	<li data-start="4600" data-end="4619">
<p data-start="4602" data-end="4619">max_total_disk_mb</p>
</li>
 	<li data-start="4620" data-end="4644">
<p data-start="4622" data-end="4644">max_total_bandwidth_mb</p>
</li>
 	<li data-start="4645" data-end="4657">
<p data-start="4647" data-end="4657">created_at</p>
</li>
</ul>
<p data-start="4659" data-end="4682">tenants table includes:</p>

<ul data-start="4683" data-end="4734">
 	<li data-start="4683" data-end="4734">
<p data-start="4685" data-end="4734">reseller_id (nullable foreign key → resellers.id)</p>
</li>
</ul>
<p data-start="4736" data-end="4787">Resellers can only manage tenants assigned to them.</p>

<ol start="10" data-start="4790" data-end="4807">
 	<li data-start="4790" data-end="4807">
<p data-start="4794" data-end="4807">Audit Logging</p>
</li>
</ol>
<p data-start="4809" data-end="4819">audit_logs</p>

<ul data-start="4820" data-end="4949">
 	<li data-start="4820" data-end="4844">
<p data-start="4822" data-end="4844">id (uuid, primary key)</p>
</li>
 	<li data-start="4845" data-end="4854">
<p data-start="4847" data-end="4854">user_id</p>
</li>
 	<li data-start="4855" data-end="4877">
<p data-start="4857" data-end="4877">tenant_id (nullable)</p>
</li>
 	<li data-start="4878" data-end="4886">
<p data-start="4880" data-end="4886">action</p>
</li>
 	<li data-start="4887" data-end="4902">
<p data-start="4889" data-end="4902">resource_type</p>
</li>
 	<li data-start="4903" data-end="4916">
<p data-start="4905" data-end="4916">resource_id</p>
</li>
 	<li data-start="4917" data-end="4929">
<p data-start="4919" data-end="4929">ip_address</p>
</li>
 	<li data-start="4930" data-end="4942">
<p data-start="4932" data-end="4942">created_at</p>
</li>
 	<li data-start="4943" data-end="4949">
<p data-start="4945" data-end="4949">hash</p>
</li>
</ul>
<p data-start="4951" data-end="5004">Optional: hash chaining for log integrity validation.</p>

<ol start="11" data-start="5007" data-end="5031">
 	<li data-start="5007" data-end="5031">
<p data-start="5011" data-end="5031">Data Integrity Rules</p>
</li>
</ol>
<ul data-start="5033" data-end="5286">
 	<li data-start="5033" data-end="5074">
<p data-start="5035" data-end="5074">All tenant resources require tenant_id.</p>
</li>
 	<li data-start="5075" data-end="5107">
<p data-start="5077" data-end="5107">Foreign keys must be enforced.</p>
</li>
 	<li data-start="5108" data-end="5157">
<p data-start="5110" data-end="5157">Soft delete recommended instead of hard delete.</p>
</li>
 	<li data-start="5158" data-end="5202">
<p data-start="5160" data-end="5202">Unique constraint required on domain_name.</p>
</li>
 	<li data-start="5203" data-end="5250">
<p data-start="5205" data-end="5250">Transactions required for provisioning flows.</p>
</li>
 	<li data-start="5251" data-end="5286">
<p data-start="5253" data-end="5286">Usage must be updated atomically.</p>
</li>
</ul>
<ol start="12" data-start="5289" data-end="5320">
 	<li data-start="5289" data-end="5320">
<p data-start="5293" data-end="5320">Recommended Database Engine</p>
</li>
</ol>
<p data-start="5322" data-end="5355">PostgreSQL is recommended due to:</p>

<ul data-start="5357" data-end="5561">
 	<li data-start="5357" data-end="5386">
<p data-start="5359" data-end="5386">Strong relational integrity</p>
</li>
 	<li data-start="5387" data-end="5436">
<p data-start="5389" data-end="5436">JSONB support for flexible configuration fields</p>
</li>
 	<li data-start="5437" data-end="5467">
<p data-start="5439" data-end="5467">Reliable transaction support</p>
</li>
 	<li data-start="5468" data-end="5501">
<p data-start="5470" data-end="5501">Mature indexing and performance</p>
</li>
 	<li data-start="5502" data-end="5561">
<p data-start="5504" data-end="5561">Row-Level Security capability (optional future hardening)</p>
</li>
</ul>
<ol start="13" data-start="5564" data-end="5585">
 	<li data-start="5564" data-end="5585">
<p data-start="5568" data-end="5585">Future Extensions</p>
</li>
</ol>
<ul data-start="5587" data-end="5720">
 	<li data-start="5587" data-end="5608">
<p data-start="5589" data-end="5608">cluster_nodes table</p>
</li>
 	<li data-start="5609" data-end="5631">
<p data-start="5611" data-end="5631">backup_records table</p>
</li>
 	<li data-start="5632" data-end="5657">
<p data-start="5634" data-end="5657">snapshot_metadata table</p>
</li>
 	<li data-start="5658" data-end="5676">
<p data-start="5660" data-end="5676">api_tokens table</p>
</li>
 	<li data-start="5677" data-end="5703">
<p data-start="5679" data-end="5703">session_management table</p>
</li>
 	<li data-start="5704" data-end="5720">
<p data-start="5706" data-end="5720">billing tables</p>
</li>
</ul>
<ol start="14" data-start="5723" data-end="5751">
 	<li data-start="5723" data-end="5751">
<p data-start="5727" data-end="5751">Architectural Guarantees</p>
</li>
</ol>
<ul data-start="5753" data-end="5995">
 	<li data-start="5753" data-end="5797">
<p data-start="5755" data-end="5797">Strict tenant isolation at database level.</p>
</li>
 	<li data-start="5798" data-end="5833">
<p data-start="5800" data-end="5833">RBAC enforced before data access.</p>
</li>
 	<li data-start="5834" data-end="5884">
<p data-start="5836" data-end="5884">Resource limits centrally defined and validated.</p>
</li>
 	<li data-start="5885" data-end="5940">
<p data-start="5887" data-end="5940">Usage tracking synchronized with provisioning engine.</p>
</li>
 	<li data-start="5941" data-end="5995">
<p data-start="5943" data-end="5995">Referential integrity enforced across all relations.</p>
</li>
</ul>
<p data-start="5997" data-end="6097">This database architecture forms the technical foundation of WCP360’s multi-tenant hosting platform.</p>
