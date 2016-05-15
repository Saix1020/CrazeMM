我的订单汇总信息：
url: /rest/order/summary
method: get
return:
    ok: true, false
    state: { //订单各状态的值
        TOBEPAID: 100, // 待付款
        TOBESENT: 200, // 待发货
        TOBERECEIVED: 300, //待签收
        TOBESETTLED: 400, //待结款
        TOBECONFIRMED: 401, //待确认
        COMPLETED: 500 //完成
        PAYTIMEOUT: 700 //支付超时
    }
    sum: { //用户订单汇总
        buy: { //我买的货 订单汇总
            tobepaid: 待支付
            tobereceived: 待签收
        },
        supply: { //我卖的货 订单汇总
            tobesent: 待发货
            tobeconfirmed: 待确认
        }
    }
示例数据：
{"sum":{"buy":{"tobepaid":2,"tobereceived":1},"supply":{"tobesent":1,"tobeconfirmed":0}},"state":{"COMPLETED":500,"TOBESENT":200,"TOBEPAID":100,"TOBECONFIRMED":401,"TOBERECEIVED":300,"TOBESETTLED":400,"PAYTIMEOUT":700},"ok":true}

 我的订单分页列表：
url: /rest/order
method: get
data:
     t: b, 买货订单; s, 卖货订单
     pn: 当前第几页，从1开始
     state: 状态，多个时，逗号隔开
return:
    pageNumber: 当前页
    totalPage: 总页数
    pageSize: 每页条数
    totalRow：总条数
    list: [{
        "isAnoy":false, //是否匿名供货，匿名进不显示供货人/求购人信息
        "quantity":10, //供货数量
        "userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/1_cut.jpg", //供货人/求购人图片
        "goodName":"华为-荣耀4A 黑 8G 全网通",//手机名称
        "price":1.00, //价格
        "updateTime":"2016-05-05 22:15:43", //更新时间 
        "id":842, // 订单流水号
        "state":100, //状态
        "userName":"189mm" //供货人/求购人用户名
    },
    ...
    ]

示例数据:
{"page":{"totalRow":2,"pageNumber":1,"totalPage":1,"pageSize":10,"list":[{"isAnoy":false,"quantity":10,"userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/1_cut.jpg","goodName":"华为-荣耀4A 黑 8G 全网通","price":1.00,"updateTime":"2016-05-05 22:15:43","id":842,"state":100,"userName":"189mm"},{"isAnoy":false,"quantity":10,"userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/1_cut.jpg","goodName":"苹果-iPhone SE 粉 16G 全网通","price":1.00,"updateTime":"2016-05-05 22:15:33","id":840,"state":100,"userName":"189mm"}]},"ok":true}

保存供货订单
url: /rest/order
method: post
data: {
    'order.sid': 供货单号
    'supply.version': 供货信息的版本号
    'orderType': 供货类型
    'save_order_token': 保存订单的TOKEN
    ''
}


删除订单 - 批量删除 支付超时 的订单
url: /rest/order/remove/ids
method: get
或者
url:
url: /rest/order/ids
method: delete
data: ids：订单ID， 多个订单 逗号隔开

取消订单 - 撤销 待支付 的订单
url: /rest/order/cancel/id
method: get
data: id：订单ID


订单详情：
url: /rest/order/id
method: get
data: {t: b} // 订单类型，b 我买的货， s 我卖的货
return: 
sample data: 数据中包含了一些不必要的字段，暂时先放着，后面再去掉
{
    "ok":true,
    "order":{
        "isAnoy":false, //  是否匿名订单
        "quantity":100, // 数量
        "userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/1_cut.jpg", //交易方用户头像
        "goodName":"锋达通-C100 白 暂缺 电信CDMA", //货品名称 
        "price":1.00, //价格
        "updateTime":"2016-05-12 18:36:12", // 更新时间
        "id":897, //ID
        "state":500, //状态
        "userName":"189mm", // 交易方用户名
        "addr":{ // 供货地址，未付款订单时，没有该属性
            "uid":4,
            "zipCode":"210000",
            "isDefault":false,
            "phone":null,
            "street":"山西路68号27FAB座", //街道名称
            "contact":"周墨宣",  // 联系人
            "mobile":"15301598286", //手机
            "pid":16,
            "id":17,
            "region":"江苏-南京-鼓楼区", //地区名
            "did":1835,
            "cid":220
        },
        "logs":[{ //状态日志，按时间轴倒序排序
            "uid":1,
            "createTime":"2016-05-12 18:36:12", //时间 
            "oldState":401,
            "comment":"卖方确认结款", // 日志内容
            "id":2608,
            "oid":897,
            "userName":"189mm", // 日志生成时的完成操作的登录用户
            "newStateLabel":"完成", // 操作后状态名称
            "newState":500
        },{
            "uid":1,
            "createTime":"2016-05-12 18:33:04",
            "oldState":400,
            "comment":"更新订单状态",
            "id":2607,
            "oid":897,
            "userName":"189mm",
            "newStateLabel":"结款待确认",
            "newState":401
        },{
            "uid":4,
            "createTime":"2016-05-12 18:31:50",
            "oldState":300,
            "comment":"买方签收",
            "id":2606,
            "oid":897,
            "userName":"xuanxuan",
            "newStateLabel":"待结款",
            "newState":400
        },{
            "uid":1,
            "createTime":"2016-05-12 18:31:23",
            "oldState":200,
            "comment":"卖方发货",
            "id":2605,
            "oid":897,
            "userName":"189mm",
            "newStateLabel":"待签收",
            "newState":300
        },{
            "uid":1,
            "createTime":"2016-05-12 18:30:19",
            "oldState":100,
            "comment":"网银支付成功",
            "id":2604,
            "oid":897,
            "userName":"189mm",
            "newStateLabel":"待发货",
            "newState":200
        },{
            "uid":4,
            "createTime":"2016-05-12 18:28:13",
            "oldState":0,
            "comment":"保存购买订单",
            "id":2603,
            "oid":897,
            "userName":"xuanxuan",
            "newStateLabel":"待付款",
            "newState":100
        }]
    }
}

WEB中的处理：
模板
<!-- page orderDetail -->
<div id="orderDetail" data-role="page">
    <!-- hd -->
    <div class="hd header">
        <div class="header_ld"></div>
        <div class="header_md">订单详情</div>
    </div>
    <!-- / hd -->
    <!-- bd -->
    <div class="bd">
        <div class="ui_floor msg">
            <p>请尽快付款</p>
            <p>1小时后订单将自动过期</p>
        </div>
        <!-- addr -->
        <div class="ui_floor">
            <div class="addr">
                <div class="addr_hd">
                    <span class="fl">潘蓉</span>
                    <span class="fr">15195879182</span>
                </div>
                <div class="addr_bd weui_cells weui_cells_access">
                    <div class="weui_cell">
                        <div class="weui_cell_hd">
                            <img src="${ctx}/weui/images/location.png">
                        </div>
                        <div class="weui_cell_bd weui_cell_primary">
                            <p>江苏省南京市栖霞区紫东路1号紫东国际创意园A4栋6楼</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- / addr -->
        <!-- data_item -->
        <div class="ui_floor data_item">
            <div class="item_hd">
                <label>订单号：688</label>
                <span><img src="${ctx}/weui/images/img_01.jpg">江苏良晋信息科技有限公司</span>
            </div>
            <div class="item_bd">
                <a href="javascript:;" class="item_prod_name">苹果-iphone 6s（金/16G/全网通）</a>
                <p class="item_order_quantity">数量：10台</p>
                <p class="item_order_price">单台定价：￥5555</p>
            </div>
            <div class="item_fd">
                <span class="item_prod_price">总价：<span class="red price">¥<em>5555</em>.00</span></span>
            </div>
        </div>
        <!-- / data_item -->
        <div class="ui_floor">
            <section id="cd-timeline" class="cd-container">
                <div class="cd-timeline-block">
                    <div class="cd-timeline-img cd-even"></div>
                    <div class="cd-timeline-content">
                        <p>【待发货】 xuanxuan 保存购买订单</p>
                        <p>2016-05-11 00:00:00</p>
                    </div>
                </div>
                <div class="cd-timeline-block">
                    <div class="cd-timeline-img cd-odd"></div>
                    <div class="cd-timeline-content">
                        <p>【待发货】 xuanxuan 保存购买订单</p>
                        <p>2016-05-11 00:00:00</p>
                    </div>
                </div>
            </section>  
        </div>
    </div>
    <!-- / bd -->
    <!-- fd -->
    <#-- 暂时先不在详情页中执行相关操作
    <div class="fd">
        <div class="fd_r fr">
            <a href="javascript:showDialog();">付款</a>
        </div>
    </div> -->
    <!-- / fd -->
</div>

JS文件内容：

define(['common/ajaxDefault', 'common/dialog'], function($, dlg){
    
    var type = ""; //订单类别：b, 买货订单；s, 供货订单
    var detailPage = $('#orderDetail');
    var orderMap = {};
    
    /**
     * 渲染状态提醒
     */
    
    /**
     * 渲染地址信息
     */
    function updateAddr(addr){
        var addrEl = $('.addr');

        if(addr) {
            addrEl.find('.addr_hd .fl').html(addr['contact']);
            addrEl.find('.addr_hd .fr').html(addr['mobile']);
            addrEl.find(".addr_bd p").html(addr['region'] + ' ' + addr['street']);
            addrEl.parents('.ui_floor').show();
        }
        else {
            addrEl.parents('.ui_floor').hide();
        }

    }
    
    /** 
     * 更新订单信息块
     */
    function updateDataItem(dataItem, order){
        var orderPrice = order['quantity'] *order['price'];
        dataItem.find('.item_hd label').html('订单号：' + order['id']);
        if(order['isAnoy']) {
            dataItem.find('.item_hd span').html('<img src=" ' +  $189mm.ctx +'/weui/images/img_01.jpg"/>匿名');
        } else {
            dataItem.find('.item_hd span').html('<img src=" ' +  order['userImage'] +'"/>' + order['userName']);
        }
        
        dataItem.find('.item_bd .item_prod_name').html(order['goodName']);
        dataItem.find('.item_bd p.item_order_quantity').html('数量：' + order['quantity'] + '台');
        dataItem.find('.item_bd p.item_order_price').html('单台定价：￥' + order['price']);
        
        dataItem.find('.item_fd .price em').html(orderPrice);
    }
    
    /**
     * 渲染订单日志，按时间倒序排列
     */
    function renderLog(log, latest) {
        var content = '';
        content += '<div class="cd-timeline-block">'
           + '          <div class="cd-timeline-img ' + (latest?'cd-even' : 'cd-odd') +'"></div>'
           + '          <div class="cd-timeline-content">'
           + '               <p>【' + log['newStateLabel'] + '】 ' + log['userName'] +' '+ log['comment']+ '</p>'
           + '               <p>' + log['createTime'] +'</p>'
           + '          </div>'
           + '      </div>';
        return content;
    }
    
    return {
        'init': function(){
            var listPage = $($('div[data-role="page"]')[0]);
            type = listPage.hasClass('buy_order_page')? 'b' : 's';
            detailPage.find('.header_ld').click(function(){
                detailPage.hide();
                listPage.show();
            });
        },
        
        'loadData': function(id){
            $.getJSON($189mm['ctx'] + '/rest/order/' + id, {'t': type}, function(data){
                if(data['ok']) {
                   var order = orderMap[id] = data['order'];
                   
                   //console.dir(order); 更新地址信息
                   if(order['addr']) {
                      updateAddr(order['addr']);
                   } else {
                      updateAddr(false);
                   }
                   //更新订单信息
                   updateDataItem(detailPage.find('.data_item'), order);
                   
                   //渲染订单日志
                   var timeLine = $('#cd-timeline');
                   timeLine.empty();
                   var logs;
                   if( logs = order['logs']){
                       var len = logs.length;
                       for(var i=0; i<len; i++) {
                           var content = renderLog(logs[i], (i == 0));
                           timeLine.append(content);
                       }
                   }
                    
                } else {
                    dlg.alert({'msg': data['msg']});
                }
            })
        }
    }
    
});
