package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("message", "Chào mừng đến với Web Shop!");
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);

    }
}
