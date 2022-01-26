package ru.job4j.cinema.store;

import org.apache.commons.dbcp2.BasicDataSource;
import ru.job4j.cinema.model.Account;
import ru.job4j.cinema.model.Ticket;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InfoStore {

    private static final Logger LOGGER = Logger.getLogger(InfoStore.class.getName());

    private final BasicDataSource pool = new BasicDataSource();

    private InfoStore() {
        Properties cfg = new Properties();
        try (BufferedReader io = new BufferedReader(
                new InputStreamReader(
                        InfoStore.class.getClassLoader()
                                .getResourceAsStream("db.properties")
                )
        )) {
            cfg.load(io);
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        try {
            Class.forName(cfg.getProperty("jdbc.driver"));
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        pool.setDriverClassName(cfg.getProperty("jdbc.driver"));
        pool.setUrl(cfg.getProperty("jdbc.url"));
        pool.setUsername(cfg.getProperty("jdbc.username"));
        pool.setPassword(cfg.getProperty("jdbc.password"));
        pool.setMinIdle(5);
        pool.setMaxIdle(10);
        pool.setMaxOpenPreparedStatements(100);
    }

    private static final class Lazy {
        private static final InfoStore INST = new InfoStore();
    }

    public static InfoStore instOf() {
        return Lazy.INST;
    }

    public Collection<Ticket> findBookedTickets() {
        List<Ticket> tickets = new ArrayList<>();
        try (Connection cn = pool.getConnection();
             PreparedStatement ps =  cn.prepareStatement("SELECT * FROM ticket")
        ) {
            try (ResultSet it = ps.executeQuery()) {
                while (it.next()) {
                    tickets.add(new Ticket().setSessionId(it.getInt("session_id"))
                                    .setRow(it.getInt("row"))
                                    .setCell(it.getInt("cell"))
                            .setAccountId(it.getInt("account_id")));
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception: ", e);
        }
        return tickets;
    }

    public Ticket save(Ticket ticket) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps =  cn.prepareStatement(
                     "INSERT INTO ticket(session_id, row, cell, account_id) VALUES (?,?,?,?)",
                     PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setInt(1, ticket.getSessionId());
            ps.setInt(2, ticket.getRow());
            ps.setInt(3, ticket.getCell());
            ps.setInt(4, ticket.getAccountId());
            ps.execute();
            try (ResultSet id = ps.getGeneratedKeys()) {
                if (id.next()) {
                    ticket.setId(id.getInt(1));
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception: ", e);
        }
        return ticket;
    }

    public Account save(Account account) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps =  cn.prepareStatement(
                     "INSERT INTO account(username, phone, email) VALUES (?,?,?)",
                     PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, account.getUsername());
            ps.setString(2, account.getPhone());
            ps.setString(3, account.getEmail());
            ps.execute();
            try (ResultSet id = ps.getGeneratedKeys()) {
                if (id.next()) {
                    account.setId(id.getInt(1));
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception: ", e);
        }
        return account;
    }

    private void update(Account account) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn
                     .prepareStatement("UPDATE account SET username=?  WHERE id=?")) {
            ps.setString(1, account.getUsername());
            ps.setInt(3, account.getId());
            ps.execute();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception: ", e);
        }
    }

    public Account findByPhone(String phone) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps =  cn.prepareStatement("SELECT * FROM account WHERE phone = ?")
        ) {
            ps.setString(1, phone);
            try (ResultSet it = ps.executeQuery()) {
                if (it.next()) {
                    return new Account().setId(it.getInt("id"))
                            .setUsername(it.getString("username"))
                            .setEmail("email")
                            .setPhone(phone);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception: ", e);
        }
        return null;
    }

    public static void main(String[] args) {

        InfoStore store = InfoStore.instOf();
        store.save(new Account()
                .setPhone("222")
                .setUsername("aaa")
                .setEmail("ppp"));

    }
}
