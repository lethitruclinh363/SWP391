<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin • Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Giữ Tailwind giống homepage nếu cần -->
        <script src="https://cdn.tailwindcss.com"></script>

        <style>
            :root{
                --bg:#f8f9fa;
                --surface:#ffffff;
                --ink:#2d3748;
                --muted:#4a5568;
                --primary:#667eea;
                --line: rgba(0,0,0,0.06);
                --radius:12px;
            }

            *{
                box-sizing:border-box;
            }
            html,body{
                height:100%;
            }
            body{
                margin:0;
                background:var(--bg);
                color:var(--ink);
                font-family:-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            }

            /* Header */
            header{
                position:sticky;
                top:0;
                z-index:50;
                background:var(--surface);
                color:var(--ink);
                box-shadow:0 2px 8px rgba(0,0,0,0.05);
            }
            .header-wrap{
                max-width:1200px;
                margin:0 auto;
                padding:1rem 1.25rem;
                display:flex;
                align-items:center;
                justify-content:space-between;
            }
            .brand{
                font-weight:800;
                font-size:1.25rem;
                letter-spacing:.2px;
            }
            .brand-accent{
                color:var(--primary);
            }
            .btn{
                border:none;
                border-radius:999px;
                padding:.45rem .9rem;
                font-weight:600;
                cursor:pointer;
                text-decoration:none;
                display:inline-flex;
                align-items:center;
                gap:.25rem;
            }
            .btn-outline{
                background:transparent;
                color:var(--ink);
                border:1px solid var(--line);
            }
            .btn-muted{
                background:#f3f4f6;
                color:var(--ink);
            }

            /* Layout */
            .shell{
                max-width:1200px;
                margin:0 auto;
                display:flex;
                gap:1.25rem;
                padding:1.25rem;
            }
            .sidebar{
                width:260px;
                min-width:260px;
                background:var(--surface);
                border:1px solid var(--line);
                border-radius:var(--radius);
                height:max(72vh, 600px);
                position:sticky;
                top:88px;
                padding:.75rem;
            }
            .nav-link{
                display:flex;
                align-items:center;
                gap:.6rem;
                padding:.65rem .75rem;
                margin:.2rem 0;
                border-radius:10px;
                color:var(--muted);
                text-decoration:none;
                font-weight:600;
            }
            .nav-link:hover{
                background:#f3f4f6;
                color:var(--ink);
            }
            .nav-link.active{
                background:#eef2ff;
                color:var(--primary);
            }
            .main{
                flex:1;
                min-width:0;
            }

            /* Cards */
            .card{
                background:var(--surface);
                border:1px solid var(--line);
                border-radius:var(--radius);
            }

            /* Hero / Welcome */
            .welcome-card{
                padding:2rem 2.25rem;
                margin-bottom:1.25rem;
                background:linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color:#fff;
                border:none;
                position:relative;
                overflow:hidden;
            }
            .welcome-card::after{
                content:"";
                position:absolute;
                inset:auto -80px -80px auto;
                width:220px;
                height:220px;
                background:rgba(255,255,255,0.08);
                border-radius:999px;
            }
            .welcome-title{
                font-size:2rem;
                font-weight:800;
                margin:0 0 .5rem 0;
            }
            .welcome-sub{
                margin:0;
                max-width:520px;
                opacity:.95;
            }

            /* Stats */
            .stats-grid{
                display:grid;
                grid-template-columns:repeat(4, minmax(160px,1fr));
                gap:1rem;
            }
            .stat{
                display:flex;
                align-items:center;
                gap:1rem;
                padding:1rem 1.1rem;
            }
            .stat .icon{
                width:42px;
                height:42px;
                border-radius:10px;
                background:#eef2ff;
                color:var(--primary);
                display:grid;
                place-items:center;
                font-weight:800;
            }
            .stat .label{
                font-size:.85rem;
                color:var(--muted);
            }
            .stat .value{
                font-size:1.25rem;
                font-weight:800;
            }
            .stat .hint{
                font-size:.75rem;
                color:var(--muted);
            }

            /* Quick links */
            .quick-links{
                margin-top:1.25rem;
                padding:1.1rem 1.25rem 1.25rem;
            }
            .quick-title{
                font-weight:700;
                margin-bottom:.6rem;
            }
            .quick-grid{
                display:grid;
                grid-template-columns:repeat(auto-fit, minmax(180px,1fr));
                gap:.75rem;
            }
            .quick-item{
                padding:.8rem .9rem;
                border-radius:10px;
                border:1px solid var(--line);
                text-decoration:none;
                color:var(--ink);
                display:flex;
                align-items:center;
                justify-content:space-between;
            }
            .quick-item span:first-child{
                font-weight:600;
            }
            .quick-item small{
                color:var(--muted);
                font-size:.8rem;
            }

            @media (max-width: 900px){
                .shell{
                    flex-direction:column;
                }
                .sidebar{
                    position:static;
                    width:100%;
                    min-width:0;
                    height:auto;
                }
                .stats-grid{
                    grid-template-columns:repeat(2, minmax(0,1fr));
                }
            }
            @media (max-width: 600px){
                .stats-grid{
                    grid-template-columns:1fr;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <div class="header-wrap">
                <div class="brand">
                    ShopHub <span class="brand-accent">Admin</span>
                </div>
                <div style="display:flex; align-items:center; gap:.6rem;">
                    <span style="color:var(--muted); font-weight:600;">
                        Hello, Admin
                    </span>
                    <a href="<%=request.getContextPath()%>/" class="btn btn-outline">
                        Go to Site
                    </a>
                    <a href="<%=request.getContextPath()%>/logout" class="btn btn-muted">
                        Logout
                    </a>
                </div>
            </div>
        </header>

        <div class="shell">
            <!-- Sidebar -->
            <aside class="sidebar">
                <nav>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">Home</a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">Users</a>
                    <!-- các mục khác -->
                </nav>
            </aside>

            <!-- Main -->
            <main class="main">
                <h1 style="font-size:1.6rem; font-weight:800; margin-bottom:1rem;">
                    User Management
                </h1>

                <!-- Toolbar filter -->
                <form class="toolbar" method="get"
                      action="${pageContext.request.contextPath}/admin/users">
                    <div class="group">
                        <input class="input" type="text" name="q"
                               value="${param.q}" placeholder="Search username / email / phone">
                        <select class="select" name="roleId">
                            <option value="">All roles</option>
                            <option value="1">ADMIN</option>
                            <option value="2">STAFF</option>
                            <option value="3">CUSTOMER</option>
                        </select>
                        <select class="select" name="status">
                            <option value="">All status</option>
                            <option value="1" ${param.status=='1' ? 'selected' : ''}>Active</option>
                            <option value="0" ${param.status=='0' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    <div class="group" style="margin-left:auto;">
                        <button class="btn btn-outline" type="submit">Filter</button>
                        <a class="btn btn-muted" href="${pageContext.request.requestURI}">Reset</a>
                        <a class="btn btn-primary"
                           href="${pageContext.request.contextPath}/admin/users/create">+ Create User</a>
                    </div>
                </form>

                <!-- Bảng user -->
                <div class="card" style="margin-top:1rem;">
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th style="width:72px;">ID</th>
                                    <th>Username</th>
                                    <th>Full name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Roles</th>
                                    <th style="width:120px;">Status</th>
                                    <th style="width:160px;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty userList}">
                                    <tr>
                                        <td colspan="8" style="text-align:center; color:var(--muted);">
                                            No users
                                        </td>
                                    </tr>
                                </c:if>

                                <c:forEach var="u" items="${userList}">
                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.username}</td>
                                        <td>${u.fullName}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td>
                                            <c:forEach var="r" items="${u.roles}">
                                                <span class="badge
                                                      ${r.name=='ADMIN' ? 'admin' :
                                                        (r.name=='STAFF' ? 'staff' : 'customer')}">
                                                          ${r.name}
                                                      </span>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <span class="badge"
                                                      style="background:${u.status==1 ? '#dcfce7':'#fee2e2'};
                                                      color:${u.status==1 ? '#065f46':'#991b1b'};
                                                      font-weight:800;">
                                                    ${u.status==1 ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>
                                            <td style="display:flex; gap:.4rem; flex-wrap:wrap;">
                                                <a class="btn btn-outline"
                                                   href="${pageContext.request.contextPath}/admin/users/edit?id=${u.id}">
                                                    Edit
                                                </a>
                                                <button type="button" class="btn btn-warning"
                                                        onclick="toggleStatus(${u.id}, ${u.status==1 ? 0 : 1})">
                                                    ${u.status==1 ? 'Deactivate' : 'Activate'}
                                                </button>
                                                <button type="button" class="btn btn-danger"
                                                        onclick="resetPassword(${u.id})">
                                                    Reset PW
                                                </button>
                                                <button type="button" class="btn btn-primary"
                                                        onclick="openRoleModal(${u.id})">
                                                    Roles
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
            </div>

            <script>
                const ctx = '${pageContext.request.contextPath}';
                // JS toggleStatus / resetPassword / openRoleModal giống file bạn đang có
            </script>
        </body>
    </html>
