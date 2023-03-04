import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;
import java.util.List;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Arrays;

public class SQLStatementCreator extends JFrame implements ActionListener {

    /* statements */
    ArrayList<StringBuilder> statements = new ArrayList<>();

    /* gui attributes */
    private JLabel tableLabel;
    private JLabel columnLabel;
    private JLabel conditionLabel;
    private JList<String> tableList, columnList;
    private JTextField conditionField;
    private JButton generateButton;
    private JTextArea statementsArea;

    /* constructor */
    public SQLStatementCreator(DatabaseInformation db) {

        /* set up GUI attributes */
        tableLabel = new JLabel("Tables to join:");
        columnLabel = new JLabel("Columns to select:");
        conditionLabel = new JLabel("Condition:");
        tableList = new JList<>(db.getTables());
        tableList.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        columnList = new JList<>(new String[]{});

        /* add listener to table list */
        tableList.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                /* get values from table list */
                List<String> selectedValuesList = tableList.getSelectedValuesList();

                /* put the values from each table in a hash set */
                HashSet<String> allSelectedValues = new HashSet<>();
                for (String selectedValue : selectedValuesList) {
                    allSelectedValues.addAll(List.of(db.getAttributes(selectedValue)));
                }
                /* add select all option */
                allSelectedValues.add("*");

                /* convert it to an array and put it in the column list */
                String[] allAttributes = allSelectedValues.toArray(new String[0]);
                Arrays.sort(allAttributes);
                columnList.setListData(allAttributes);
            }
        });

        /* add functionality elements */
        conditionField = new JTextField();
        statementsArea = new JTextArea();
        statementsArea.setEditable(false);

        generateButton = new JButton("Generate SQL");
        generateButton.addActionListener(this);

        /* add GUI elements to the J panel */
        JPanel panel = new JPanel(new GridLayout(4, 2));
        panel.add(tableLabel);
        panel.add(new JScrollPane(tableList));
        panel.add(columnLabel);
        panel.add(columnList);
        panel.add(new JScrollPane(columnList));
        panel.add(conditionLabel);
        panel.add(conditionField);
        panel.add(statementsArea);
        panel.add(generateButton);
        add(panel);

        /* setup panel/frame properties */
        setTitle("SQL Query Builder");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        pack();
        setVisible(true);
    }

    /* handle pressing the generate button */
    public void actionPerformed(ActionEvent e) {

        if (e.getSource() == generateButton) {

            /* extract the user inputs from the GUI */
            String[] tables = tableList.getSelectedValuesList().toArray(new String[0]);
            String[] columns = columnList.getSelectedValuesList().toArray(new String[0]);
            String condition = conditionField.getText();

            /* start creating the sql statement */
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT ");

            /* add selected columns */
            sql.append(columns[0]);
            for (int i = 1; i < columns.length; i++) {
                sql.append(", ").append(columns[i]);
            }
            sql.append(" ");
            //sql.deleteCharAt(sql.length() - 1); // remove trailing comma

            sql.append(" FROM ").append(tables[0]);

            /* add tables */
            for (int i = 1; i < tables.length; i++) {
                sql.append(" NATURAL JOIN ").append(tables[i]);
            }
            if (!condition.isEmpty()) {
                sql.append(" WHERE ").append(condition);
            }

            /* output to area and save */
            statementsArea.append(sql + "\n");
            sql.append(";");
            this.statements.add(sql);
            System.out.println(this.statements);
        }
    }

    public static void main(String[] args) {

        /* create database information */
        DatabaseInformation db = new DatabaseInformation();
        db.addTable("employees", new String[]{"empID", "empName", "email", "roleID", "deptID"});
        db.addTable("projects", new String[]{"projectID", "projectName", "budget", "start_date"});
        db.addTable("departments", new String[]{"deptID", "deptName"});
        db.addTable("roles", new String[]{"roleID", "title", "salary"});
        db.addTable("project_employees", new String[]{"projectID", "empID"});
        db.addTable("project_departments", new String[]{"deptID", "projectID"});

        new SQLStatementCreator(db);
    }
}