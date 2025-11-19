<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin • Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Giữ Tailwind giống homepage nếu cần -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
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
            <asi    de class="sidebar">
                <nav>
                    <a class="nav-link active" href="<%=request.getContextPath()%>/admin">Home</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/users">Users</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/roles">Roles</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/customers">Customers</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/addresses">Addresses</a>
                    <div style="height:1px; background:var(--line); margin:.6rem 0;"></div>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/products">Products</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/orders">Orders</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/reports">Reports</a>
                    <a class="nav-link" href="<%=request.getContextPath()%>/admin/settings">Settings</a>
                </nav>
                </aside>

                <!-- Main -->
                <main class="main">
                    <!-- Welcome -->
                    <div class="card welcome-card">
                        <h1 class="welcome-title">Welcome to Admin Dashboard</h1>
                        <p class="welcome-sub">
                            Từ đây bạn có thể quản lý người dùng, sản phẩm, đơn hàng, báo cáo và các thiết lập hệ thống
                            cho ShopHub. Chọn một mục ở thanh bên trái để bắt đầu.
                        </p>
                    </div>

                    <!-- Stats -->
                    <div class="stats-grid">
                        <div class="card stat">
                            <div class="icon">👤</div>
                            <div>
                                <div class="label">Total Users</div>
                                <div class="value">
                                    <%= request.getAttribute("statTotalUsers") != null ? request.getAttribute("statTotalUsers") : "0"%>
                                </div>
                                <div class="hint">Tổng số tài khoản trong hệ thống</div>
                            </div>
                        </div>
                        <div class="card stat">
                            <div class="icon">✅</div>
                            <div>
                                <div class="label">Active Users</div>
                                <div class="value">
                                    <%= request.getAttribute("statActive") != null ? request.getAttribute("statActive") : "0"%>
                                </div>
                                <div class="hint">Đang hoạt động</div>
                            </div>
                        </div>
                        <div class="card stat">
                            <div class="icon">🕒</div>
                            <div>
                                <div class="label">New (7 days)</div>
                                <div class="value">
                                    <%= request.getAttribute("statNew7d") != null ? request.getAttribute("statNew7d") : "0"%>
                                </div>
                                <div class="hint">Tài khoản mới tạo</div>
                            </div>
                        </div>
                        <div class="card stat">
                            <div class="icon">🛍️</div>
                            <div>
                                <div class="label">Orders (7 days)</div>
                                <div class="value">
                                    <%= request.getAttribute("statOrders7d") != null ? request.getAttribute("statOrders7d") : "0"%>
                                </div>
                                <div class="hint">Đơn hàng gần đây</div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick links -->
                    <div class="card quick-links">
                        <div class="quick-title">Quick actions</div>
                        <div class="quick-grid">
                            <a class="quick-item" href="<%=request.getContextPath()%>/admin/users">
                                <span>Manage Users</span>
                                <small>Xem / chỉnh sửa quyền & trạng thái</small>
                            </a>
                            <a class="quick-item" href="<%=request.getContextPath()%>/admin/products">
                                <span>Manage Products</span>
                                <small>Thêm / cập nhật sản phẩm</small>
                            </a>
                            <a class="quick-item" href="<%=request.getContextPath()%>/admin/orders">
                                <span>View Orders</span>
                                <small>Theo dõi đơn hàng mới nhất</small>
                            </a>
                            <a class="quick-item" href="<%=request.getContextPath()%>/admin/reports">
                                <span>Reports</span>
                                <small>Xem thống kê doanh thu</small>
                            </a>
                        </div>
                    </div>
                </main>
        </div>

    </body>
</html>
