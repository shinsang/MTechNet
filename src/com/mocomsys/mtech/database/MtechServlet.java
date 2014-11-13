package com.mocomsys.mtech.database;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MtechServlet
 */
@WebServlet("/MtechServlet")
public class MtechServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MtechServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String add = request.getParameter("add");
		String phone = request.getParameter("phone");

		request.setAttribute("1", name);
		request.setAttribute("2", sex);
		request.setAttribute("3", add);
		request.setAttribute("4", phone);

		RequestDispatcher rd = request.getRequestDispatcher("request.jsp");
		rd.forward(request, response);

//		PrintWriter out = response.getWriter();
//		out.print("Print  --> name["+name +"] sex["+sex+"] add["+add+"] phone["+phone+"]");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
