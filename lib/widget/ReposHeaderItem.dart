import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/model/Repository.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/CommonUtils.dart';
import 'package:gsy_github_app_flutter/common/utils/NavigatorUtils.dart';
import 'package:gsy_github_app_flutter/widget/GSYCardItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYIConText.dart';
import 'package:gsy_github_app_flutter/widget/GSYSelectItemWidget.dart';

/**
 * 仓库详情信息头控件
 * Created by guoshuyu
 * Date: 2018-07-18
 */
class ReposHeaderItem extends StatelessWidget {
  final SelectItemChanged selectItemChanged;

  final ReposHeaderViewModel reposHeaderViewModel;

  ReposHeaderItem(this.reposHeaderViewModel, this.selectItemChanged) : super();

  ///底部仓库状态信息，比如star数量等
  _getBottomItem(IconData icon, String text, onPressed) {
    return new Expanded(
      child: new Center(
        child: new FlatButton(
          onPressed: onPressed,
          padding: new EdgeInsets.all(0.0),
          child: new GSYIConText(
            icon,
            text,
            GSYConstant.subLightSmallText,
            Color(GSYColors.subLightTextColor),
            15.0,
            padding: 3.0,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String createStr = reposHeaderViewModel.repositoryIsFork
        ? "Frok at " + " " + reposHeaderViewModel.repositoryParentName + '\n'
        : "Create at " + " " + reposHeaderViewModel.created_at + "\n";

    String updateStr = "Last commit at " + reposHeaderViewModel.push_at;

    String infoText = createStr + ((reposHeaderViewModel.push_at != null) ? updateStr : '');

    return new Column(
      children: <Widget>[
        new GSYCardItem(
          color: new Color(GSYColors.primaryValue),
          child: new Container(
            ///背景头像
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(reposHeaderViewModel.ownerPic),
              ),
            ),
            child: new Container(
              ///透明黑色遮罩
              decoration: new BoxDecoration(
                color: Color(GSYColors.primaryDarkValue & 0xA0FFFFFF),
              ),
              child: new Padding(
                padding: new EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        ///用户名
                        new RawMaterialButton(
                          constraints: new BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                          padding: new EdgeInsets.all(0.0),
                          onPressed: () {
                            NavigatorUtils.goPerson(context, reposHeaderViewModel.ownerName);
                          },
                          child: new Text(reposHeaderViewModel.ownerName, style: GSYConstant.normalTextActionWhiteBold),
                        ),
                        new Text(" /", style: GSYConstant.normalTextMitWhiteBold),

                        ///仓库名
                        new Text(" " + reposHeaderViewModel.repositoryName, style: GSYConstant.normalTextMitWhiteBold),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        ///仓库语言
                        new Text(reposHeaderViewModel.repositoryType ?? "--", style: GSYConstant.subLightSmallText),
                        new Container(width: 5.3, height: 1.0),

                        ///仓库大小
                        new Text(reposHeaderViewModel.repositorySize ?? "--", style: GSYConstant.subLightSmallText),
                        new Container(width: 5.3, height: 1.0),

                        ///仓库协议
                        new Text(reposHeaderViewModel.license ?? "--", style: GSYConstant.subLightSmallText),
                      ],
                    ),

                    ///仓库描述
                    new Container(
                        child: new Text(reposHeaderViewModel.repositoryDes ?? "---", style: GSYConstant.subLightSmallText),
                        margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                        alignment: Alignment.topLeft),

                    ///创建状态
                    new Container(
                        child: new Text(infoText, style: GSYConstant.subLightSmallText),
                        margin: new EdgeInsets.only(top: 6.0, bottom: 2.0, right: 5.0),
                        alignment: Alignment.topRight),
                    new Divider(
                      color: Color(GSYColors.subTextColor),
                    ),
                    new Padding(
                        padding: new EdgeInsets.all(0.0),

                        ///创建数值状态
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _getBottomItem(
                              GSYICons.REPOS_ITEM_STAR,
                              reposHeaderViewModel.repositoryStar,
                              () {
                                NavigatorUtils.gotoCommonList(context, reposHeaderViewModel.repositoryName, "user", "repo_star",
                                    userName: reposHeaderViewModel.ownerName, reposName: reposHeaderViewModel.repositoryName);
                              },
                            ),
                            new Container(width: 0.3, height: 25.0, color: Color(GSYColors.subLightTextColor)),
                            _getBottomItem(
                              GSYICons.REPOS_ITEM_FORK,
                              reposHeaderViewModel.repositoryFork,
                              () {
                                NavigatorUtils.gotoCommonList(context, reposHeaderViewModel.repositoryName, "repository", "repo_fork",
                                    userName: reposHeaderViewModel.ownerName, reposName: reposHeaderViewModel.repositoryName);
                              },
                            ),
                            new Container(width: 0.3, height: 25.0, color: Color(GSYColors.subLightTextColor)),
                            _getBottomItem(
                              GSYICons.REPOS_ITEM_WATCH,
                              reposHeaderViewModel.repositoryWatch,
                              () {
                                NavigatorUtils.gotoCommonList(context, reposHeaderViewModel.repositoryName, "user", "repo_watcher",
                                    userName: reposHeaderViewModel.ownerName, reposName: reposHeaderViewModel.repositoryName);
                              },
                            ),
                            new Container(width: 0.3, height: 25.0, color: Color(GSYColors.subLightTextColor)),
                            _getBottomItem(
                              GSYICons.REPOS_ITEM_ISSUE,
                              reposHeaderViewModel.repositoryIssue,
                              () {},
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///底部头
        new GSYSelectItemWidget([
          GSYStrings.repos_tab_activity,
          GSYStrings.repos_tab_commits,
        ], selectItemChanged)
      ],
    );
  }
}

class ReposHeaderViewModel {
  String ownerName = '---';
  String ownerPic = "---";
  String repositoryName = "---";
  String repositorySize = "---";
  String repositoryStar = "---";
  String repositoryFork = "---";
  String repositoryWatch = "---";
  String repositoryIssue = "---";
  String repositoryIssueClose = "";
  String repositoryIssueAll = "";
  String repositoryType = "---";
  String repositoryDes = "---";
  String repositoryLastActivity = "";
  String repositoryParentName = "";
  String created_at = "";
  String push_at = "";
  String license = "";
  bool repositoryStared = false;
  bool repositoryForked = false;
  bool repositoryWatched = false;
  bool repositoryIsFork = false;

  ReposHeaderViewModel();

  ReposHeaderViewModel.fromHttpMap(ownerName, reposName, Repository map) {
    this.ownerName = ownerName;
    if (map == null || map.owner == null) {
      return;
    }
    this.ownerPic = map.owner.avatar_url;
    this.repositoryName = reposName;
    this.repositoryStar = map.watchersCount != null ? map.watchersCount.toString() : "";
    this.repositoryFork = map.forksCount != null ? map.forksCount.toString() : "";
    this.repositoryWatch = map.subscribersCount != null ? map.subscribersCount.toString() : "";
    this.repositoryIssue = map.openIssuesCount != null ? map.openIssuesCount.toString() : "";
    //this.repositoryIssueClose = map.closedIssuesCount != null ? map.closed_issues_count.toString() : "";
    //this.repositoryIssueAll = map.all_issues_count != null ? map.all_issues_count.toString() : "";
    this.repositorySize = ((map.size / 1024.0)).toString().substring(0, 3) + "M";
    this.repositoryType = map.language;
    this.repositoryDes = map.description;
    this.repositoryIsFork = map.fork;
    this.license = map.license != null ? map.license.name : "";
    this.repositoryParentName = map.parent != null ? map.parent.fullName : null;
    this.created_at = CommonUtils.getNewsTimeStr(map.createdAt);
    this.push_at = CommonUtils.getNewsTimeStr(map.pushedAt);
  }
}
