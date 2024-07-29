package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.List;


import lombok.Data;

@Data
public class DataRevenueByMonth {
    private Integer monh;
    private Double totalAmount;

    public static List<DataRevenueByMonth> convert(List<Object[]> list) {
        List<DataRevenueByMonth> finalList = new ArrayList<DataRevenueByMonth>();
        for (Object[] o : list) {
            DataRevenueByMonth dataRevenueByMonth = new DataRevenueByMonth();
            dataRevenueByMonth.setMonh((Integer) o[0]);
            dataRevenueByMonth.setTotalAmount((Double) o[1]);
            ;
            finalList.add(dataRevenueByMonth);
        }
        return finalList;
    }
}
