package ru.job4j.cinema.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ru.job4j.cinema.model.Account;
import ru.job4j.cinema.model.Ticket;
import ru.job4j.cinema.store.InfoStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

public class HallServlet extends HttpServlet {

    private static final Gson GSON = new GsonBuilder().create();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setContentType("application/json; charset=utf-8");
        OutputStream output = resp.getOutputStream();
        String json = GSON.toJson(InfoStore.instOf().findBookedTickets());
        output.write(json.getBytes(StandardCharsets.UTF_8));
        output.flush();
        output.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        req.setCharacterEncoding("UTF-8");

        InfoStore store = InfoStore.instOf();
        int sessionId = Integer.valueOf(req.getParameter("session"));
        int row = Integer.valueOf(req.getParameter("row"));
        int cell = Integer.valueOf(req.getParameter("cell"));
        String username = req.getParameter("username");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        if (InfoStore.instOf().findByPhone(phone) == null) {
            Account account = new Account()
                    .setUsername(username)
                    .setEmail(email)
                    .setPhone(phone);
            store.save(account);
        }

        store.save(new Ticket()
                .setSessionId(sessionId)
                .setCell(cell)
                .setRow(row)
                .setAccountId(store.findByPhone(phone).getId()));

        resp.sendRedirect(req.getContextPath());
    }

}
