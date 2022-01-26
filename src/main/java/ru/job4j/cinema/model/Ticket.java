package ru.job4j.cinema.model;

import java.util.Objects;

public class Ticket {

    private int sessionId;
    private int row;
    private int cell;
    private int accountId;
    private int id;

    public int getSessionId() {
        return sessionId;
    }

    public int getRow() {
        return row;
    }

    public Ticket setRow(int row) {
        this.row = row;
        return this;
    }

    public int getCell() {
        return cell;
    }

    public Ticket setCell(int cell) {
        this.cell = cell;
        return this;
    }

    public Ticket setSessionId(int sessionId) {
        this.sessionId = sessionId;
        return this;
    }

    public int getAccountId() {
        return accountId;
    }

    public Ticket setAccountId(int accountId) {
        this.accountId = accountId;
        return this;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Ticket ticket = (Ticket) o;
        return sessionId == ticket.sessionId && row == ticket.row && cell == ticket.cell
                && accountId == ticket.accountId && id == ticket.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(sessionId, row, cell, accountId, id);
    }

    @Override
    public String toString() {
        return "Ticket{" + "sessionId=" + sessionId + ", row=" + row + ", cell="
                + cell + ", accountId=" + accountId + ", id=" + id + '}';
    }
}
