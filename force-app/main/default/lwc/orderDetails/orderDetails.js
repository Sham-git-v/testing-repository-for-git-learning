import { LightningElement } from 'lwc';

export default class OrderDetails extends LightningElement {

    orders = [ { orderId: 1, customerName: 'Alice', orderAmount: 250, orderDate: '2024-01-01' },
         { orderId: 2, customerName: 'Bob', orderAmount: 450, orderDate: '2024-01-02' },
          { orderId: 3, customerName: 'Charlie', orderAmount: 350, orderDate: '2024-01-03' } ];
}